local pkgs = {
	"nixpkgs-fmt",
	"jdtls",
	"yaml-language-server",
	"eslint_d",
}
local reg = require("mason-registry")
for _, pname in ipairs(pkgs) do
	local pkg = reg.get_package(pname)
	if not pkg:is_installed() then
		print(string.format("[masonDownload.lua]: %s is not installed. Installing.", pname))
		local handle = pkg:install(nil)
		--while handle.state ~= "CLOSED" do
		--  print(handle.stdout)
		-- end
	end
end
