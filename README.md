# WinLast Tweaker

PowerShell script with simple TUI to tweak your Windows 10/11 installation. It includes several tweaks which can improve your system stability, performance and security.

> [!WARNING]
> This software can harm your system or data. Use at your own risk!

## Features

- [x] Easy to use
- [x] No installation required
- [x] Secure - you see which commands will be runned
- [x] Comes with simple TUI
- [ ] Check status of tweak

## Usage

Just run following in elevvated PowerShell:
```powershell
irm https://github.com/ankddev/winlast/blob/main/winlast.ps1 | iex
```
If you see errors aboutrunning permission - review your permission settings, apply them and run command again.

Or, you can just download file `winlast.ps1` and run it manually.

Then, you will see list of tweaks. You can move using arrows. Press <kbd>Enter</kbd> to see details or <kbd>Esc</kbd> to exit.
When you opened details you can press <kbd>Esc</kbd> to return to list, <kbd>1</kbd> to apply tweak or <kbd>0</kbd> to revert tweak.

> [!NOTE]
> You may see some lags and blinks when moving. This is normal due to PS limitations.

## Contributing

1. Fork repository
2. Clone your fork
3. Create new branch
4. Make changes
5. Test your changes
6. Commit and push changes
7. Open PR

## License

Licensed under MIT License.

