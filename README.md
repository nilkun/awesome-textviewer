# awesome-textviewer
A very simple textfile viewer for the awesome window manager.

1. copy lua files to ./config/awesome/textviewer
2. Create a textfile named "textfile.txt" in your home directory.
Or use the one in the repo.
3. add the following line to rc.lua's require section:
		local textviewer = require("textviewer/textviewer")
4. add the following to rc.lua's wibox section:
		textviewer,


