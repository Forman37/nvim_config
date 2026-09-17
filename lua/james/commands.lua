return {

    -- Create CPP Project
    vim.api.nvim_create_user_command("CppProj", function(opts)
        local name = opts.args
        local files = {
            ["CMakeLists.txt"] = string.format([[
cmake_minimum_required(VERSION 3.20)
project(%s)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_compile_options(-Wall -Wextra -Wpedantic)

add_executable(%s src/main.cpp)

target_include_directories(%s PRIVATE include)
]], name, name, name),
            ["src/main.cpp"] = [[
#include <iostream>

int main() {
    std::cout << "Hello from ]] .. name .. [[!\n";
    return 0;
}
]],
            [".clang-format"] = "BasedOnStyle: Google\n",
        }

        vim.fn.mkdir("src", "p")
        vim.fn.mkdir("include", "p")
        for path, content in pairs(files) do
            local f = io.open(path, "w")
            if f then
                f:write(content)
                f:close()
            end
        end
        vim.fn.system("ln -sf build/compile_commands.json compile_commands.json")
        print("Created C++20 project: " .. name)
    end, { nargs = 1 })

    --[[
Then from inside your target folder in NeoVim:
```
:CppProject TelemetryViewer
```

## 3. Shell Script + NeoVim Integration

If you already have a shell script (`mkproject.sh`) that scaffolds projects, you can just call it from NeoVim:
```
:!mkproject_cpp TelemetryViewer
]]
}
