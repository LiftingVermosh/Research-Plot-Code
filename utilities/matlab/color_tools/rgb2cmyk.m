function cmyk = rgb2cmyk(rgb)
% RGB2CMYK 将RGB颜色转换为CMYK颜色空间
%   输入:
%       rgb - RGB颜色值，格式为:
%             单色: [R, G, B] (各分量0-1)
%             或多色: n x 3矩阵
%   输出:
%       cmyk - CMYK颜色值，范围[0,1]
    
    % 验证输入
    if size(rgb, 2) ~= 3
        error('输入必须是n x 3矩阵');
    end
    
    % 转换计算
    k = 1 - max(rgb, [], 2);
    c = (1 - rgb(:,1) - k) ./ (1 - k);
    m = (1 - rgb(:,2) - k) ./ (1 - k);
    y = (1 - rgb(:,3) - k) ./ (1 - k);
    
    % 处理黑色特殊情况
    black_idx = (k == 1);
    c(black_idx) = 0;
    m(black_idx) = 0;
    y(black_idx) = 0;
    
    % 组合结果
    cmyk = [c, m, y, k];
    
    % 确保值在[0,1]范围内
    cmyk = max(0, min(1, cmyk));
end
