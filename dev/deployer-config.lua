--- @type DeployerUserConfig
local env = require('user-env')
--- run with: deployer --config dev/deployer-config.lua -q -n --watch

--- @type DeploymentConfig
local c = {
  version = "1.0.0",
  name = "ActionbarPlus-Masque",
  --- @type table<string, ProjectAddOnInfo>
  addons = {
    ["Lib-2-0"] = {
      deploy=true,
      as = 'LibUtil'
    },
  },
  deployments = {
    ["classic-era"] = {
      deploy = true,
      dir=env.wow.classic_era.addOnDir
    },
    ["classic"] = {
      deploy = true,
      dir=env.wow.classic.addOnDir
    },
    ["classic-anniversary"] = {
      deploy = true,
      dir=env.wow.classic_anniversary.addOnDir,
    },
    ["retail"] = {
      deploy = true,
      dir=env.wow.retail.addOnDir,
    },
  }
}
return c
