require("cmake-tools").setup {
  cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=On" },
  cmake_build_directory = "build",
}
