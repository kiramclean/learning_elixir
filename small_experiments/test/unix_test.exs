defmodule UnixTest do
  use ExUnit.Case

  test "ps_ax outputs some processes" do
    output = """
    331   ??  S      0:11.09 /Applications/BetterSnapTool.app/Contents/MacOS/BetterSnapTool
    422   ??  S      0:00.88 /Library/DropboxHelperTools/Dropbox_u501/dbfseventsd
    423   ??  S      0:03.39 /Library/DropboxHelperTools/Dropbox_u501/dbfseventsd
    424   ??  S      0:02.88 /Library/DropboxHelperTools/Dropbox_u501/dbfseventsd
    474   ??  Ss     0:00.02 /System/Library/Frameworks/AudioToolbox.framework/XPCServices/com.apple.audio.SandboxHelper.xpc/Contents/MacOS/com.apple.audio.SandboxHelper
    10963   ??  Ss     0:34.77 /usr/local/Cellar/macvim/7.4-106/MacVim.app/Contents/MacOS/Vim -f -g .
    10972   ??  U      0:21.03 /usr/local/Cellar/macvim/7.4-106/MacVim.app/Contents/MacOS/MacVim -MMNoWindow yes
    """
    assert Unix.ps_ax == output
  end

  test "grep(lines, thing), returns lines that match 'thing'" do
    lines = """
    foo
    bar
    thing foo
    baz
    thing whee
    """
    output = ["thing foo", "thing whee"]
    assert Unix.grep(lines, ~r/thing/) == output
  end

  test "awk(input, 1) splits on whitespace and returns the first column" do
    input = ["thing woo", "foo bar"]
    output = ["thing", "foo"]
    assert Unix.awk(input, 1) == output
  end

  test "the whole pipeline works" do
    assert(Unix.ps_ax |> Unix.grep(~r/vim/) |> Unix.awk(1)) == ["10963", "10972"]
  end
end
