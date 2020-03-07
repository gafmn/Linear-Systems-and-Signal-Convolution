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

function[f, g] = pad(f, g)
    m = length(f) + length(g) - 1
    f = [f, zeros(1, m - length(f))]
    g = [g, zeros(1, m - length(g))]
endfunction

x = [1, 2, 3, 5]
g = [0, 4]

[x,g] = pad(x,g)


[matr] = produceShiftMatrix(x)



y = mtlb_t(convolve(matr, mtlb_t(g)))
disp(y)
