IRC_NAME = "irc.wav"
DATA_PATH = "./data/"
VOICE_NAME = "voice.wav"
DRUMS_NAME = "drums.wav"
VIOLIN_NAME = "violin.wav"
SPEECH_NAME = "speech.wav"

SAVE_PATH = "./results/"

x_voice = 0
y_voice = 0
original_voice = 0

x_voice_b = 0
y_voice_b = 0

function[f, g, l] = Pad(f, g)
    l = length(f) + length(g) - 1
    f = [f(1,:), zeros(1, l - length(f(1,:)))]
    g = [g, zeros(1, l - length(g))]
endfunction

function[y] = Conv(x, h)
    [a, b, l] = Pad(x, h)
    f1 = fft(a)
    f2 = fft(b)
    f3 = f1 .* f2
    y = ifft(f3)
endfunction

function[y_conv, x1] = LoadSaveConv(filename1, filename2)
    [x1, fs1] = wavread(DATA_PATH + filename1)
    [x2, fs2] = wavread(DATA_PATH + filename2)
    tic()
    y_conv = Conv(x1, x2)
    mprintf("The time for handmade convolution %s: %f\n", filename1, toc())
    y = y_conv
    savepath = SAVE_PATH + "FFTCONV_" + filename1
    wavwrite(y, fs1, savepath)
    mprintf("Written %s.\n", savepath)
endfunction

function [y] = LoadSaveBuiltinConv(filename1, filename2)
    [x1, fs1] = wavread(DATA_PATH + filename1)
    [x2, fs2] = wavread(DATA_PATH + filename2)
    tic()
    y = convol(x1(1,:), x2)
    mprintf("The time for Scilabs convolution %s: %f\n", filename1, toc())
    savepath = SAVE_PATH + "BUILTIN_" + filename1
    wavwrite(y, fs1, savepath)
    mprintf("Written %s.\n", savepath)
endfunction

clf
[conv_voice, origin_voice] = LoadSaveConv(VOICE_NAME, IRC_NAME)
[in_conv_voice] = LoadSaveBuiltinConv(VOICE_NAME, IRC_NAME)
subplot(231)
plot(origin_voice, 'r')
title("Before convolution")
h1 = legend(VOICE_NAME)
subplot(232)
plot(conv_voice, 'g')
title("After handmade convolution")
h1 = legend(VOICE_NAME)
subplot(233)
plot(in_conv_voice, 'b')
title("After internal convolution")
h1 = legend(VOICE_NAME)

[conv_drums, origin_drums] = LoadSaveConv(DRUMS_NAME, IRC_NAME)
[in_conv_drums] = LoadSaveBuiltinConv(DRUMS_NAME, IRC_NAME)
subplot(234)
plot(origin_drums, 'r')
title("Before convolution")
h2 = legend(DRUMS_NAME)
subplot(235)
plot(conv_drums, 'g')
title("After handmade convolution")
h2 = legend(DRUMS_NAME)
subplot(236)
plot(in_conv_drums, 'b')
title("After internal convolution")
h2 = legend(DRUMS_NAME)

[conv_speech, origin_speech] = LoadSaveConv(SPEECH_NAME, IRC_NAME)
[in_conv_speech] = LoadSaveBuiltinConv(SPEECH_NAME, IRC_NAME)

[conv_violin, original_violin] = LoadSaveConv(VIOLIN_NAME, IRC_NAME)
[in_conv_violin] = LoadSaveBuiltinConv(VIOLIN_NAME, IRC_NAME)



