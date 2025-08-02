% utilities/matlab/export_tools/auto_adjust_dpi.m
function auto_adjust_dpi(fig, base_dpi)
% 自动优化渲染器设置以适应高DPI导出
% 输入:
%   fig - 图形句柄
%   base_dpi - 导出的基础DPI

% 检测图像对象
im_objs = findobj(fig, 'Type', 'image');

if ~isempty(im_objs)
    % 更可靠的方法：检查图像数据尺寸
    img_data = get(im_objs(1), 'CData');
    [~, img_width, ~] = size(img_data);
    
    % 获取坐标轴尺寸（以英寸为单位）
    ax = get(im_objs(1), 'Parent');
    original_units = get(ax, 'Units');
    set(ax, 'Units', 'inches');
    ax_pos = get(ax, 'Position');
    set(ax, 'Units', original_units);
    
    % 计算显示尺寸（英寸）
    display_width = ax_pos(3);
    
    % 计算实际DPI
    actual_dpi = img_width / display_width;
    
    % 调整渲染器
    if actual_dpi > base_dpi * 1.2
        set(fig, 'Renderer', 'opengl');
        fprintf('切换到OpenGL渲染器以适应高分辨率图像 (实际DPI: %.1f, 导出DPI: %d)\n', actual_dpi, base_dpi);
    end
end
end

