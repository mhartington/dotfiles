--[[
Example:

--]]
local uv = vim.uv
local a = require('mh.async')

local M = {}

local function add(func)
    M[func] = a.async(uv[func])
end

---[[ stolen from plenary start

add('close') -- close a handle

-- filesystem operations
add('fs_open')
add('fs_read')
add('fs_close')
add('fs_unlink')
add('fs_write')
add('fs_mkdir')
add('fs_mkdtemp')
-- 'fs_mkstemp',
add('fs_rmdir')
add('fs_scandir')
add('fs_stat')
add('fs_fstat')
add('fs_lstat')
add('fs_rename')
add('fs_fsync')
add('fs_fdatasync')
add('fs_ftruncate')
add('fs_sendfile')
add('fs_access')
add('fs_chmod')
add('fs_fchmod')
add('fs_utime')
add('fs_futime')
-- 'fs_lutime',
add('fs_link')
add('fs_symlink')
add('fs_readlink')
add('fs_realpath')
add('fs_chown')
add('fs_fchown')
-- 'fs_lchown',
add('fs_copyfile')

M.fs_opendir = a.async(function(path, entries, callback)
    return uv.fs_opendir(path, callback, entries)
end)

add('fs_readdir')
add('fs_closedir')
add('fs_statfs')

-- stream
add('shutdown')
add('listen')
-- add('read_start', 2) -- do not do this one, the callback is made multiple times
add('write')
add('write2')
add('shutdown')

-- tcp
add('tcp_connect')
-- 'tcp_close_reset',

-- pipe
add('pipe_connect')

-- udp
add('udp_send')
add('udp_recv_start')

-- fs event (wip make into async await event)
-- fs poll event (wip make into async await event)

-- dns
add('getaddrinfo')
add('getnameinfo')

---]] copy from plenary end

local simple_job_native = a.async(function(opts, callback)
    local pipe_stdout = uv.new_pipe()
    local pipe_stderr = uv.new_pipe()
    local stdout = ''
    local stderr = ''

    local nop = function() end
    local handle
    handle = uv.spawn(opts.command, {
        args = opts.args,
        stdio = { nil, pipe_stdout, pipe_stderr },
        cwd = opts.cwd,
        env = opts.env,
    }, function(code, signal)
        callback({
            code = code,
            signal = signal,
            stdout = vim.trim(stdout),
            stderr = vim.trim(stderr),
        })

        uv.close(handle, nop)
        uv.close(pipe_stdout, nop)
        uv.close(pipe_stderr, nop)
    end)

    uv.read_start(pipe_stdout, function(err, data)
        assert(not err, err)
        if data then
            print(string.format('stdout[%s]', data))
            stdout = stdout .. data
        end
    end)

    uv.read_start(pipe_stderr, function(err, data)
        assert(not err, err)
        if data then
            stderr = stderr .. data
        end
    end)
end)

local simple_job_plenary = a.async(function(opts, callback)
    local stdout = ''
    local stderr = ''
    local job_desc = vim.tbl_deep_extend('force', opts, {
        on_stdout = function(err, chunk)
            assert(not err, err)
            stdout = stdout .. chunk
        end,
        on_stderr = function(err, chunk)
            assert(not err, err)
            stderr = stderr .. chunk
        end,
        on_exit = function(_job, code, signal)
            callback({
                code = code,
                signal = signal,
                stdout = stdout,
                stderr = stderr,
            })
        end,
    })
    require('plenary.job'):new(job_desc):start()
end)

if pcall(require, 'plenary.job') then
    M.simple_job = simple_job_plenary
else
    vim.notify('[dotvim.util.async.uv] plenary not found, using native job', 'DEBUG')
    M.simple_job = simple_job_native
end

-- require('dotvim.util.async.uv').example_read_file('/path/to/file')
M.example_read_file = a.wrap(function(path)
    local auv = require('dotvim.util.async.uv')

    local start = auv.now() -- call sync function

    local err, fd = auv.fs_open(path, 'r', 438).await()
    assert(not err, err)

    local err, stat = auv.fs_fstat(fd).await()
    assert(not err, err)

    local err, data = auv.fs_read(fd, stat.size, 0).await()
    assert(not err, err)

    print(data)

    local err = auv.fs_close(fd).await()
    assert(not err, err)

    print('cost: ', auv.now() - start, 'ms')
end)

return setmetatable(M, {
    __index = uv,
})
