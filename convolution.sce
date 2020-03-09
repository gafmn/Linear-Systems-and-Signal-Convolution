filename_hlop = "hlop.wav"
filename_another = "./data/drums.wav"
savepath = "./"

function[y] = convolve(f, g)
    y = f * g;
endfunction;

function[s_v] = shift(v)
    v_len = length(v)
    s_v = [v(v_len), v(1:v_len - 1)]
endfunction

function[matr] = produceShiftMatrix(x)
    x_len = length(x)
    matr = zeros(x_len, x_len)
    for i = 1:x_len
        matr(:,i) = [x]
        x = shift(x)
    end
endfunction

function[f, g, l] = pad(f, g)
    l = length(f) + length(g) - 1
    f = [f, zeros(1, l - length(f))]
    g = [g, zeros(1, l - length(g))]
endfunction


function[] = apply_conv(filename1, filename2)
    [x1, fs1] = wavread(filename2)
    [x2, fs2] = wavread(filename1)

    x3 = [0, 0, 1, 1, 1, 1, 0]
    x4 = [0, 1, 1, 0, 1]
    
    [x, g, l] = pad(x3, x4)
    y = []
    for i = 1:l
        y(i) = x * g'
        x = shift(x)
        mprintf("%d / %d\n", i, l)
    end
//    [matr] = produceShiftMatrix(x)
//    y = mtlb_t(convolve(matr, mtlb_t(g)))
    //wavwrite(y, fs1, "RESULT.wav")
    disp(y)
endfunction

function [] = apply_real_conv(filename1, filename2)
    [x1, fs1] = wavread(filename2)
    [x2, fs2] = wavread(filename1)
    x = [0, 0, 1, 1, 1, 1, 0]
    g = [0, 1, 1, 0, 1]
    y = conv(x, g)
    disp(y)
//    wavwrite(y, fs1, "RESULT_REAL.wav")
endfunction



apply_conv(filename_hlop, filename_another)
apply_real_conv(filename_hlop, filename_another)

//[x,g] = pad(x,g)

    
//[matr] = produceShiftMatrix(x)


//y = mtlb_t(convolve(matr, mtlb_t(g)))
//res = conv(x, g)
//disp("Inside function")
//disp(res)
//disp("Our function")
//disp(y)
