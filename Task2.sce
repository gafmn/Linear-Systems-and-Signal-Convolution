// y[n] = b0 * w[n] + b1 * w[n-1]...
// w[n] = x[n] - a1 * w[n-1] - a2 * w[n-2]...

function [wn] = GetWn(w, a, x, n)
    wn = x(n)
    for i = 1:length(a) 
        if (n - i < 1)
            break
        end
        wn = wn - (a(i) * w(n-i))
    end
endfunction

function [yn] = GetYn(b, w, n)
    yn = 0
    for i = 1:length(b)
        if (n - i < 1) 
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
        mprintf("W: %d / %d\n", i, lx)
    end
endfunction

function [y] = MakeY(b, w)
    y = []
    lw = length(w)
    for i = 1:length(w)
        y(i) = GetYn(b, w, i)
        mprintf("Y: %d / %d\n", i, lw)
    end
endfunction

function [y] = IIR(x, a, b)
    w = MakeW(a, x)
    y = MakeY(b, w)
endfunction

[x, fs] = wavread("data/voice.wav")
plot(x)
a = [-0.3769782747249014, -0.19680764477614976]
b = [0.40495734254626874, -0.8099146850925375, 0.4049573425462687]
y = IIR(x, a, b)
wavwrite(y, fs, "result.wav")
plot(y)
