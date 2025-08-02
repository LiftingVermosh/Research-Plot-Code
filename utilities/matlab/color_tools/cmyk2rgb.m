function rgb = cmyk2rgb(cmyk)
% CMYK2RGB 将CMYK颜色转换为RGB颜色空间
%   输入:
%       cmyk - CMYK颜色值，格式为:
%              单色: [C, M, Y, K] (各分量0-1)
%              或多色: n x 4矩阵 (每行代表一个颜色)
%   输出:
%       rgb  - 对应的RGB值，范围[0,1]
%              单色输出: [R, G, B]
%              多色输出: n x 3矩阵

    % 验证输入
    if size(cmyk, 2) ~= 4
        error(sprintf("输入必须是以下之一:\n" + ...
            "\t1.单色行向量\n" + ...
            "\t2.多色 n x 4 矩阵"));
    end
    
    % 转换计算 (使用标准转换公式)
    r = 1 - min(1, cmyk(:,1) .* (1 - cmyk(:,4)) + cmyk(:,4));
    g = 1 - min(1, cmyk(:,2) .* (1 - cmyk(:,4)) + cmyk(:,4));
    b = 1 - min(1, cmyk(:,3) .* (1 - cmyk(:,4)) + cmyk(:,4));
    
    % 组合结果
    rgb = [r, g, b];
    
    % 确保值在[0,1]范围内
    rgb = max(0, min(1, rgb));
end
