IRC_NAME = "irc.wav"
DATA_PATH = "./data/"
VOICE_NAME = "voice.wav"
DRUMS_NAME = "drums.wav"
VIOLIN_NAME = "violin.wav"
SPEECH_NAME = "speech.wav"

SAVE_PATH = "./results/"

function[f, g, l] = Pad(f, g)
    l = length(f) + length(g) - 1
    f = [f(1,:), zeros(1, l - length(f(1,:)))]
    g = [g, zeros(1, l - length(g))]
endfunction

function[y] = Conv(x, h)
    [a, b, l] = Pad(x, h)
    f1 = fft(a)
    f2 = fft(b)
    f3 = []
    for i = 1:l
        f3(i) = f1(i) * f2(i)
    end
    y = ifft(f3)
endfunction

function[] = LoadSaveConv(filename1, filename2)
    [x1, fs1] = wavread(DATA_PATH + filename1)
    [x2, fs2] = wavread(DATA_PATH + filename2)
    y = Conv(x1, x2)
    savepath = SAVE_PATH + "FFTCONV_" + filename1
    wavwrite(y, fs1, savepath)
    mprintf("Written %s.\n", savepath)
endfunction

function [] = LoadSaveBuiltinConv(filename1, filename2)
    [x1, fs1] = wavread(DATA_PATH + filename1)
    [x2, fs2] = wavread(DATA_PATH + filename2)
    y = convol(x1(1,:), x2)
    savepath = SAVE_PATH + "BUILTIN_" + filename1
    wavwrite(y, fs1, savepath)
    mprintf("Written %s.\n", savepath)
endfunction

LoadSaveConv(VOICE_NAME, IRC_NAME)
LoadSaveConv(DRUMS_NAME, IRC_NAME)
LoadSaveConv(VIOLIN_NAME, IRC_NAME)
LoadSaveConv(SPEECH_NAME, IRC_NAME)

LoadSaveBuiltinConv(VOICE_NAME, IRC_NAME)
LoadSaveBuiltinConv(DRUMS_NAME, IRC_NAME)
LoadSaveBuiltinConv(VIOLIN_NAME, IRC_NAME)
LoadSaveBuiltinConv(SPEECH_NAME, IRC_NAME)
