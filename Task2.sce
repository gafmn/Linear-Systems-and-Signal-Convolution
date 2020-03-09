// y[n] = b0 * w[n] + b1 * w[n-1]...
// w[n] = x[n] + a1 * w[n-1] + a2 * w[n-2]...

function [wn] = GetWn(w, a, x, n)
    wn = x(n)
    for i = 1:length(a) 
        if (n - i < 1)
            break
        end
        wn = wn + (a(i) * w(n-i))
    end
endfunction

function [yn] = GetYn(b, w, n)
    yn = 0
    for i = 1:length(b)
        if (n - i < 0) 
            break
        end
        yn = yn + (b(i) * w(n-i+1))
    end
endfunction

function [w] = MakeW(a, x)
    w = []
    lx = length(x)
    for i = 1:lx
        w(i) = GetWn(w, a, x, i)
    end
endfunction

function [y] = MakeY(b, w)
    y = []
    lw = length(w)
    for i = 1:lw
        y(i) = GetYn(b, w, i)
    end
endfunction

function [y] = IIR(x, a, b)
    mprintf("Started IIR.\n")
    mprintf("Building W\.\.\. ")
    w = MakeW(a, x)
    mprintf("Done.\nBuilding Y\.\.\. ")
    y = MakeY(b, w)
    mprintf("Done.\n")
endfunction

function [y] = ApplyHighpass(x)
    mprintf("Applying highpass filter.\n")
    a = [-0.3769782747249014, -0.19680764477614976]
    b = [0.40495734254626874, -0.8099146850925375, 0.4049573425462687]
    y = IIR(x, a, b)
    mprintf("Highpass done.\n")
endfunction

function [y] = ApplyLowpass(x)
    mprintf("Applying lowpass filter.\n")
    a = [1.9733442497812987, -0.9736948719763]
    b = [0.00008765554875401547, 0.00017531109750803094, 0.00008765554875401547]
    y = IIR(x, a, b)
    mprintf("Lowpass done.\n")
endfunction

function [] = LoadLowpassSave(filename, savepath)
    mprintf("Loading %s\.\.\. ", filename)
    [x, fs] = wavread(filename)
    mprintf("Done.\n", filename)
    y = ApplyLowpass(x)
    mprintf("Saving %s\.\.\. ", savepath)
    wavwrite(y, fs, savepath)
    mprintf("Done.\n", filename)
endfunction

function [] = LoadHighpassSave(filename, savepath)
    mprintf("Loading %s\.\.\. ", filename)
    [x, fs] = wavread(filename)
    mprintf("Done.\n", filename)
    y = ApplyHighpass(x)
    mprintf("Saving %s\.\.\. ", savepath)
    wavwrite(y, fs, savepath)
    mprintf("Done.\n", filename)
endfunction

LoadLowpassSave("data/Violin_Viola_Cello_Bass.wav", "data/lowpass_instruments.wav")
LoadHighpassSave("data/Violin_Viola_Cello_Bass.wav", "data/highpass_instruments.wav")
