@echo off
setlocal

set PRESETS=vs17 vs18
set VARIANTS=static shared

for %%p in (%PRESETS%) do (
    for %%v in (%VARIANTS%) do (
        call echo === Configuring %%p ^(%%v^) ===
        call cmake --preset %%p-%%v
        if errorlevel 1 goto :error

        call echo === Building %%p %%v Debug ===
        call cmake --build --preset %%p-%%v-debug
        if errorlevel 1 goto :error

        call echo === Building %%p %%v Release ===
        call cmake --build --preset %%p-%%v-release
        if errorlevel 1 goto :error

        call echo === Packaging %%p %%v ===
        call cpack --preset %%p-%%v-zip
        if errorlevel 1 goto :error
    )
)

echo.
echo === All packages created successfully ===
exit /b 0

:error
echo.
echo === Build failed ===
exit /b 1
