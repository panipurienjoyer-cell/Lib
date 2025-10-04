local cloneref = cloneref or function(o) return o end;
local httpService = cloneref(game:GetService('HttpService'));
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request;
local getassetfunc = getcustomasset or getsynasset;

local ThemeManager = {} do
	ThemeManager.Folder = 'Default';
	ThemeManager.Library = nil;
	ThemeManager.BuiltInThemes = {
		['Default']        = { 1, httpService:JSONDecode('{"FontColor":"f5f5f5","MainColor":"1f1f1f","AccentColor":"ff6b00","BackgroundColor":"141414","OutlineColor":"2a2a2a"}') },
		['Azure Drift']    = { 2, httpService:JSONDecode('{"FontColor":"f5f5f5","MainColor":"1f1f1f","AccentColor":"00bfff","BackgroundColor":"121212","OutlineColor":"2a2a2a"}') },
		['Obsidian Void']  = { 3, httpService:JSONDecode('{"FontColor":"f5f5f5","MainColor":"1f1f1f","AccentColor":"000000","BackgroundColor":"141514","OutlineColor":"2a2a2a"}') },
		['Amethyst Core']  = { 4, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"7e48a3","BackgroundColor":"232323","OutlineColor":"141414"}') },
		['Crimson Jester'] = { 5, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"db4467","BackgroundColor":"1c1c1c","OutlineColor":"373737"}') },
		['Mint Pulse']     = { 6, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"3db488","BackgroundColor":"1c1c1c","OutlineColor":"373737"}') },
		['Tokyo Night']    = { 7, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"191925","AccentColor":"6759b3","BackgroundColor":"16161f","OutlineColor":"323232"}') },
		['Ubuntu Flame']   = { 8, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"3e3e3e","AccentColor":"e2581e","BackgroundColor":"323232","OutlineColor":"191919"}') },
		['Quartz Storm']   = { 9, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"232330","AccentColor":"426e87","BackgroundColor":"1d1b26","OutlineColor":"27232f"}') },
		['Dark Crimson']   = { 10, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a0f0f","AccentColor":"ff3333","BackgroundColor":"0f0606","OutlineColor":"2a1a1a"}') },
		['Haze Violet']    = { 11, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a1226","AccentColor":"8a2be2","BackgroundColor":"100b1a","OutlineColor":"2e2240"}') },
		['Ocean Depth']    = { 12, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"0f1419","AccentColor":"00bfff","BackgroundColor":"050a0f","OutlineColor":"1f2933"}') },
		['Forest Echo']    = { 13, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"0d1b0d","AccentColor":"32cd32","BackgroundColor":"061006","OutlineColor":"1a2b1a"}') },
		['Sunset Ember']   = { 14, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1f1710","AccentColor":"ff6347","BackgroundColor":"120e08","OutlineColor":"2f2520"}') },
		['Golden Age']     = { 15, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a1a1a","AccentColor":"ffd700","BackgroundColor":"0d0d0d","OutlineColor":"2a2a2a"}') },
		['Blood Eclipse']  = { 16, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a0f0f","AccentColor":"dc143c","BackgroundColor":"0a0505","OutlineColor":"3d1a1a"}') },
		['Neon Surge']     = { 17, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"0f1a1a","AccentColor":"00ffff","BackgroundColor":"050f0f","OutlineColor":"1a3d3d"}') },
		['Royal Veil']     = { 18, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a0f1a","AccentColor":"9370db","BackgroundColor":"0f050f","OutlineColor":"3d1a3d"}') },
		['Pink Voltage']   = { 19, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a0f1a","AccentColor":"ff1493","BackgroundColor":"0f050f","OutlineColor":"3d1a3d"}') },
		['Ice Shard']      = { 20, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"0f1a1f","AccentColor":"87ceeb","BackgroundColor":"050f12","OutlineColor":"1a3d4d"}') },
		['Lava Core']      = { 21, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1f0f0a","AccentColor":"ff4500","BackgroundColor":"120805","OutlineColor":"4d1a0a"}') },
		['Midnight Realm'] = { 22, httpService:JSONDecode('{"FontColor":"c0c0c0","MainColor":"050505","AccentColor":"4169e1","BackgroundColor":"000000","OutlineColor":"1a1a1a"}') },
		['Toxic Bloom']    = { 23, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a1f0f","AccentColor":"adff2f","BackgroundColor":"0f1205","OutlineColor":"3d4d1a"}') },
		['Magenta Storm']  = { 24, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1f0f1f","AccentColor":"ff00ff","BackgroundColor":"120512","OutlineColor":"4d1a4d"}') },
		['Turquoise Mist'] = { 25, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"0f1f1a","AccentColor":"40e0d0","BackgroundColor":"051208","OutlineColor":"1a4d3d"}') },
		['Aurora']         = { 26, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1a1a2e","AccentColor":"00ffff","BackgroundColor":"0f0f1f","OutlineColor":"2a2a4d"}') },
		['Vaporwave']      = { 27, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"2a1f4d","AccentColor":"ff77ff","BackgroundColor":"1a0f2f","OutlineColor":"4d3d7a"}') },
		['Steel Core']     = { 28, httpService:JSONDecode('{"FontColor":"dcdcdc","MainColor":"2f2f2f","AccentColor":"808080","BackgroundColor":"1a1a1a","OutlineColor":"3d3d3d"}') },
		['Galaxy']         = { 29, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"0b0b2b","AccentColor":"8a2be2","BackgroundColor":"050517","OutlineColor":"1f1f4d"}') },
		['Emerald Dream']  = { 30, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"0f1f0f","AccentColor":"50fa7b","BackgroundColor":"051205","OutlineColor":"1a3d1a"}') },
		['Shadow Realm']   = { 31, httpService:JSONDecode('{"FontColor":"c0c0c0","MainColor":"0a0a0a","AccentColor":"4b0082","BackgroundColor":"000000","OutlineColor":"1a1a1a"}') },
	['Inferno']        = { 32, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"2b0f0f","AccentColor":"ff4500","BackgroundColor":"1a0505","OutlineColor":"4d1a1a"}') },
	['Mystic Forest']  = { 33, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"0f1a0f","AccentColor":"228b22","BackgroundColor":"050f05","OutlineColor":"1a3d1a"}') },
	['Twilight']       = { 34, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"2c2c54","AccentColor":"706fd3","BackgroundColor":"1a1a2e","OutlineColor":"3d3d6d"}') },
	['Neon Sunset']    = { 35, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1f0f1f","AccentColor":"ff4500","BackgroundColor":"120812","OutlineColor":"4d1a1a"}') },
}

	function ThemeManager:ApplyTheme(theme)
		local customThemeData = self:GetCustomTheme(theme)
		local data = customThemeData or self.BuiltInThemes[theme]

		if not data then return end

		local scheme = data[2]
		for idx, col in next, customThemeData or scheme do
			self.Library[idx] = Color3.fromHex(col)
			
			if Options[idx] then
				Options[idx]:SetValueRGB(Color3.fromHex(col))
			end
		end

		self:ThemeUpdate()
	end

	function ThemeManager:ThemeUpdate()

		local options = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
		for i, field in next, options do
			if Options and Options[field] then
				self.Library[field] = Options[field].Value
			end
		end

		self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor);
		self.Library:UpdateColorsUsingRegistry()
	end

	function ThemeManager:LoadDefault()		
		local theme = 'Default'
		local content = isfile(self.Folder .. '/themes/default.txt') and readfile(self.Folder .. '/themes/default.txt')

		local isDefault = true
		if content then
			if self.BuiltInThemes[content] then
				theme = content
			elseif self:GetCustomTheme(content) then
				theme = content
				isDefault = false;
			end
		elseif self.BuiltInThemes[self.DefaultTheme] then
		 	theme = self.DefaultTheme
		end

		if isDefault then
			Options.ThemeManager_ThemeList:SetValue(theme)
		else 
			self:ApplyTheme(theme)
		end
	end

	function ThemeManager:SaveDefault(theme)
		writefile(self.Folder .. '/themes/default.txt', theme)
	end

	function ThemeManager:CreateThemeManager(groupbox)
		groupbox:AddLabel('Background color'):AddColorPicker('BackgroundColor', { Default = self.Library.BackgroundColor });
		groupbox:AddLabel('Main color')	:AddColorPicker('MainColor', { Default = self.Library.MainColor });
		groupbox:AddLabel('Accent color'):AddColorPicker('AccentColor', { Default = self.Library.AccentColor });
		groupbox:AddLabel('Outline color'):AddColorPicker('OutlineColor', { Default = self.Library.OutlineColor });
		groupbox:AddLabel('Font color')	:AddColorPicker('FontColor', { Default = self.Library.FontColor });
		
		local ThemesArray = {}
		for Name, Theme in next, self.BuiltInThemes do
			table.insert(ThemesArray, Name)
		end

		table.sort(ThemesArray, function(a, b) return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1] end)

		groupbox:AddDivider()

		groupbox:AddDropdown('ThemeManager_ThemeList', { Text = 'Theme list', Values = ThemesArray, Default = 1 })
		groupbox:AddButton('Set as default', function()
			self:SaveDefault(getgenv().Linoria.Options.ThemeManager_ThemeList.Value)
			self.Library:Notify(string.format('Set default theme to %q', getgenv().Linoria.Options.ThemeManager_ThemeList.Value))
		end)

		getgenv().Linoria.Options.ThemeManager_ThemeList:OnChanged(function()
			self:ApplyTheme(getgenv().Linoria.Options.ThemeManager_ThemeList.Value)
		end)

		groupbox:AddDivider()

		groupbox:AddInput('ThemeManager_CustomThemeName', { Text = 'Custom theme name' })
		groupbox:AddButton('Create theme', function() 
			self:SaveCustomTheme(getgenv().Linoria.Options.ThemeManager_CustomThemeName.Value)

			getgenv().Linoria.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			getgenv().Linoria.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		groupbox:AddDivider()

		groupbox:AddDropdown('ThemeManager_CustomThemeList', { Text = 'Custom themes', Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 })
		groupbox:AddButton('Load theme', function() 
			self:ApplyTheme(getgenv().Linoria.Options.ThemeManager_CustomThemeList.Value) 
		end)
		groupbox:AddButton('Overwrite theme', function()
			self:SaveCustomTheme(getgenv().Linoria.Options.ThemeManager_CustomThemeName.Value)
		end)
		groupbox:AddButton('Delete theme', function()
			local name = getgenv().Linoria.Options.ThemeManager_CustomThemeName.Value

			local success, err = self:Delete(name)
			if not success then
				return self.Library:Notify('Failed to delete theme: ' .. err)
			end

			self.Library:Notify(string.format('Deleted theme %q', name))
			getgenv().Linoria.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			getgenv().Linoria.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)
		groupbox:AddButton('Refresh list', function()
			getgenv().Linoria.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			getgenv().Linoria.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)
		groupbox:AddButton('Set as default', function()
			if getgenv().Linoria.Options.ThemeManager_CustomThemeList.Value ~= nil and getgenv().Linoria.Options.ThemeManager_CustomThemeList.Value ~= '' then
				self:SaveDefault(getgenv().Linoria.Options.ThemeManager_CustomThemeList.Value)
				self.Library:Notify(string.format('Set default theme to %q', getgenv().Linoria.Options.ThemeManager_CustomThemeList.Value))
			end
		end)
		groupbox:AddButton('Reset default', function()
			local success = pcall(delfile, self.Folder .. '/themes/default.txt')
			if not success then 
				return self.Library:Notify('Failed to reset default: delete file error')
			end
				
			self.Library:Notify('Set default theme to nothing')
			getgenv().Linoria.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			getgenv().Linoria.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		ThemeManager:LoadDefault()

		local function UpdateTheme()
			self:ThemeUpdate()
		end

		getgenv().Linoria.Options.BackgroundColor:OnChanged(UpdateTheme)
		getgenv().Linoria.Options.MainColor:OnChanged(UpdateTheme)
		getgenv().Linoria.Options.AccentColor:OnChanged(UpdateTheme)
		getgenv().Linoria.Options.OutlineColor:OnChanged(UpdateTheme)
		getgenv().Linoria.Options.FontColor:OnChanged(UpdateTheme)
	end

	function ThemeManager:GetCustomTheme(file)
		local path = self.Folder .. '/themes/' .. file
		if not isfile(path) then
			return nil
		end

		local data = readfile(path)
		local success, decoded = pcall(httpService.JSONDecode, httpService, data)
		
		if not success then
			return nil
		end

		return decoded
	end

	function ThemeManager:SaveCustomTheme(file)
		if file:gsub(' ', '') == '' then
			return self.Library:Notify('Invalid file name for theme (empty)', 3)
		end

		local theme = {}
		local fields = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor", "VideoLink" }

		for _, field in next, fields do
			if field == "VideoLink" then
				theme[field] = getgenv().Linoria.Options[field].Value
			else
				theme[field] = getgenv().Linoria.Options[field].Value:ToHex()
			end
		end

		writefile(self.Folder .. '/themes/' .. file .. '.json', httpService:JSONEncode(theme))
	end

	function ThemeManager:ReloadCustomThemes()
		local list = listfiles(self.Folder .. '/themes')

		local out = {}
		for i = 1, #list do
			local file = list[i]
			if file:sub(-5) == '.json' then
				
				local pos = file:find('.json', 1, true)
				local char = file:sub(pos, pos)

				while char ~= '/' and char ~= '\\' and char ~= '' do
					pos = pos - 1
					char = file:sub(pos, pos)
				end

				if char == '/' or char == '\\' then
					table.insert(out, file:sub(pos + 1))
				end
			end
		end

		return out
	end

	function ThemeManager:SetLibrary(lib)
		self.Library = lib
	end

	function ThemeManager:BuildFolderTree()
		local paths = {}
		local parts = self.Folder:split('/')
		for idx = 1, #parts do
			paths[#paths + 1] = table.concat(parts, '/', 1, idx)
		end

		table.insert(paths, self.Folder .. '/themes')

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function ThemeManager:SetFolder(folder)
		self.Folder = folder
		self:BuildFolderTree()
	end

	function ThemeManager:CreateGroupBox(tab)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		return tab:AddLeftGroupbox('Themes')
	end

	function ThemeManager:ApplyToTab(tab)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		local groupbox = self:CreateGroupBox(tab)
		self:CreateThemeManager(groupbox)
	end

	function ThemeManager:ApplyToGroupbox(groupbox)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		self:CreateThemeManager(groupbox)
	end

	ThemeManager:BuildFolderTree()
end

return ThemeManager