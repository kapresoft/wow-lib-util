## Developer Guides

### Steps for creating a new library

1. Create the new library, library wrapper, and library XML files
2. Add the new library XML to _Lib.xml
3. Register the new library in Interface.lua and Library.lua
4. Increment the MINOR version of Library.lua so that the new version can be picked up by the addon that depends on this module.
5. Add tests if needed

### Steps for updating an existing library
1. Make the update
2. Increment the MINOR version so that it can be picked up automatically
