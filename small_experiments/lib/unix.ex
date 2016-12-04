defmodule Unix do
  def ps_ax do
    """
    331   ??  S      0:11.09 /Applications/BetterSnapTool.app/Contents/MacOS/BetterSnapTool
    422   ??  S      0:00.88 /Library/DropboxHelperTools/Dropbox_u501/dbfseventsd
    423   ??  S      0:03.39 /Library/DropboxHelperTools/Dropbox_u501/dbfseventsd
    424   ??  S      0:02.88 /Library/DropboxHelperTools/Dropbox_u501/dbfseventsd
    474   ??  Ss     0:00.02 /System/Library/Frameworks/AudioToolbox.framework/XPCServices/com.apple.audio.SandboxHelper.xpc/Contents/MacOS/com.apple.audio.SandboxHelper
    10963   ??  Ss     0:34.77 /usr/local/Cellar/macvim/7.4-106/MacVim.app/Contents/MacOS/Vim -f -g .
    10972   ??  U      0:21.03 /usr/local/Cellar/macvim/7.4-106/MacVim.app/Contents/MacOS/MacVim -MMNoWindow yes
    """
  end

  def grep(input, match) do
    String.split(input, "\n")
      |> Enum.filter(fn(line) -> Regex.match?(match, line) end)
  end

  def awk(lines, column) do
    Enum.map(lines, fn(line) ->
      String.strip(line)
        |> Unix.regex_split(~r/ /)
        |> Enum.at(column - 1)
    end)
  end

  def regex_split(lines, regex) do
    Regex.split(regex, lines, trim: true)
  end
end
