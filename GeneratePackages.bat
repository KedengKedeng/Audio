@echo off
setlocal

set PRESETS=vs17 vs18
set VARIANTS=. shared

for %%p in (%PRESETS%) do (
    for %%v in (%VARIANTS%) do (
        if "%%v"=="." (
            set "SUFFIX="
            set "LABEL=Static"
        ) else (
            set "SUFFIX=-%%v"
            set "LABEL=%%v"
        )

        call echo === Configuring %%p ^(%%LABEL%%^) ===
        call cmake --preset %%p%%SUFFIX%%
        if errorlevel 1 goto :error

        call echo === Building %%p %%LABEL%% Debug ===
        call cmake --build --preset %%p%%SUFFIX%%-debug
        if errorlevel 1 goto :error

        call echo === Building %%p %%LABEL%% Release ===
        call cmake --build --preset %%p%%SUFFIX%%-release
        if errorlevel 1 goto :error

        call echo === Packaging %%p %%LABEL%% ===
        call cpack --preset %%p%%SUFFIX%%-zip
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
