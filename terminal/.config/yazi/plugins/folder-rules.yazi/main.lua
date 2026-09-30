local newest = {
	Url(os.getenv("HOME") .. "/Downloads"),
	Url(os.getenv("HOME") .. "/Downloads/Screenshots"),
}

local function wants_newest(cwd)
	for _, dir in ipairs(newest) do
		if cwd:ends_with(dir) then
			return true
		end
	end
	return false
end

local function setup()
	ps.sub("ind-sort", function(opt)
		if wants_newest(cx.active.current.cwd) then
			opt.by, opt.reverse, opt.dir_first = "mtime", true, false
		else
			opt.by, opt.reverse, opt.dir_first = "alphabetical", false, true
		end
		return opt
	end)
end

return { setup = setup }
