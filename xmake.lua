add_rules("mode.debug", "mode.release")
add_rules("utils.hlsl2spv", {bin2c = true})

set_languages("c++17")
set_warnings("all")
add_defines("UNICODE", "_UNICODE")
add_defines("_WIN32_WINNT=0x601")

add_requires("glslang", {configs = {binaryonly = true}})
add_requires("imgui", {configs = {dx11 = true, win32 = true}})
add_requires("assimp")

target("22_Static_Cube_Mapping")
    set_kind("binary")
    set_filename("22 Static Cube Mapping")

    add_cxxflags("/source-charset:utf-8", {tools = "cl"})

    add_files("*.cpp")
    add_files("Common/*.cpp")
    
    add_files("Shaders/*.hlsl")
    
    add_packages("imgui", "assimp", "directxshadercompiler")
    
    add_syslinks(
        "d3d11", "dxgi", "dxguid",
        "D3DCompiler", "winmm",
        "user32", "gdi32", "ole32"
    )

    add_includedirs("Common")

    after_build(function (target)
        os.cp("imgui.ini", target:targetdir())
    end)
