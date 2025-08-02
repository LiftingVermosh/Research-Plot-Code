function palette = colorbrewer(scheme_name, n_colors, mode)
% COLORBREWER 获取ColorBrewer配色方案
%   提供科学可视化中常用的ColorBrewer配色方案
%   输入:
%       scheme_name - 配色方案名称 (如: 'Set1', 'RdYlBu', 'Blues')
%       n_colors    - 需要获取的颜色数量 (3-12之间)
%       mode        - 可选参数，'qual'(定性)/'seq'(连续)/'div'(发散)
%   输出:
%       palette     - n_colors x 3的RGB矩阵 (值域[0,1])

    % 内置ColorBrewer配色方案数据库 (RGB值域[0,255])
    persistent color_data;
    if isempty(color_data)
        color_data = init_color_data();
    end
    
    % 验证输入
    if nargin < 3
        mode = '';
    end
    
    % 查找匹配的配色方案
    found = false;
    palette = [];
    
    for i = 1:numel(color_data.schemes)
        scheme = color_data.schemes(i);
        if strcmpi(scheme.name, scheme_name) && ...
           any(scheme.n_colors == n_colors) && ...
           (isempty(mode) || strcmpi(scheme.type, mode))
            
            % 获取指定数量的颜色
            idx = find(scheme.n_colors == n_colors, 1);
            palette = scheme.colors{idx} / 255;
            found = true;
            break;
        end
    end
    
    % 错误处理
    if ~found
        error('未找到配色方案: %s (%d 种颜色, 类型: %s)', ...
              scheme_name, n_colors, mode);
    end
end

function data = init_color_data()
% 初始化ColorBrewer配色数据库
% 完整数据参考: https://colorbrewer2.org
    
    % 构建数据结构
    data.schemes = struct('name', {}, 'type', {}, 'n_colors', {}, 'colors', {});
    
    % 添加所有方案
    data = add_schemes(data, qual_schemes, 'qual');
    data = add_schemes(data, seq_schemes, 'seq');
    data = add_schemes(data, div_schemes, 'div');
end

function data = add_schemes(data, schemes, type)
% 辅助函数：添加配色方案到数据库
    for i = 1:size(schemes, 1)
        name = schemes{i,1};
        n_range = schemes{i,2}{1};
        colors = schemes{i,3};
        
        for j = 1:numel(colors)
            idx = numel(data.schemes) + 1;
            data.schemes(idx).name = name;
            data.schemes(idx).type = type;
            data.schemes(idx).n_colors = n_range(j);
            data.schemes(idx).colors = colors{j};
        end
    end
end
