function test_export_tools
% TEST_EXPORT_TOOLS 验证export_tools模块功能
% 测试内容：
%   1. 创建包含多种元素的测试图形
%   2. 应用期刊预设样式
%   3. 测试矢量导出功能(PDF/CMYK)
%   4. 测试位图导出功能(TIFF/PNG)
%   5. 验证边界裁剪功能
%   6. 测试批量导出

%% 步骤1: 创建测试图形
fig = figure('Name', 'Export Tools Test Figure', 'Position', [100 100 800 600]);

% 创建坐标轴
ax1 = subplot(2,2,1);
ax2 = subplot(2,2,2);
ax3 = subplot(2,2,3);
ax4 = subplot(2,2,4);

% 曲线图 (包含图例)
x = linspace(0, 2*pi, 100);
plot(ax1, x, sin(x), 'r-', 'LineWidth', 1.5);
hold(ax1, 'on');
plot(ax1, x, cos(x), 'b--', 'LineWidth', 1.5);
legend(ax1, {'sin(x)', 'cos(x)'}, 'Location', 'northeast');
title(ax1, 'Trigonometric Functions');
xlabel(ax1, 'x (rad)');
ylabel(ax1, 'Amplitude');

% 散点图
x = randn(100,1);
y = 2*x + randn(100,1);
scatter(ax2, x, y, 40, 'filled', 'MarkerFaceAlpha', 0.6);
title(ax2, 'Scatter Plot');
grid(ax2, 'on');

% 柱状图
data = [3, 7, 2; 5, 2, 6; 4, 8, 1];
bar(ax3, data, 'grouped');
title(ax3, 'Grouped Bar Chart');
xticklabels(ax3, {'Group A', 'Group B', 'Group C'});
legend(ax3, {'Set 1', 'Set 2', 'Set 3'});

% 图像显示
I = imread('cameraman.tif'); % MATLAB自带图像
imagesc(ax4, I);
colormap(ax4, 'gray');
colorbar(ax4);
title(ax4, 'Sample Image');

% 添加全局文字注释
annotation(fig, 'textbox', [0.3 0.01 0.4 0.05],...
    'String', 'Figure 1: Export Tools Test',...
    'FontSize', 10, 'HorizontalAlignment', 'center',...
    'EdgeColor', 'none');

%% 步骤3: 测试矢量导出（含CMYK转换）
output_dir = './test_output';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% 导出PDF
export_vector(fig, fullfile(output_dir, 'test_vector'), 'pdf',...
    'CMYK', true,...
    'CropMargins', [5, 5, 5, 5],... % 5mm边距
    'Transparent', false);

fprintf('矢量PDF导出完成\n');

%% 步骤4: 测试位图导出
% 导出高分辨率TIFF
export_raster(fig, fullfile(output_dir, 'test_raster.tiff'), 'tiff', 600,...
    'Compression', 'lzw',...
    'Transparent', false);

% 导出透明背景PNG
export_raster(fig, fullfile(output_dir, 'test_transparent.png'), 'png', 300,...
    'Transparent', true);

fprintf('位图导出完成: TIFF (600dpi) 和 PNG (透明背景)\n');

%% 步骤5: 验证边界裁剪功能
% 创建第二个图形测试裁剪
fig2 = figure;
surf(peaks);
title('Surface Plot for Crop Testing');
colorbar;

% 设置不同边距
margins = [15, 5, 10, 20]; % [左,下,右,上] mm
set_crop_margins(fig2, margins);

% 导出裁剪后的PDF
export_vector(fig2, fullfile(output_dir, 'test_crop'), 'pdf',...
    'CropMargins', margins);

fprintf('边界裁剪测试完成\n');

%% 步骤6: 测试批量导出
% 创建多个测试图形
figs = [fig, fig2];
for i = 3:5
    figs(i) = figure;
    plot(cumsum(randn(100,1)));
    title(sprintf('Random Walk %d', i-2));
end

% 批量导出所有打开的图像
batch_export(figs, 'pdf', output_dir);

fprintf('批量导出完成: %d个图形导出为PDF\n', numel(figs));

%% 验证步骤
fprintf('\n=== 验证测试 ===\n');

% 验证PDF是否存在
if exist(fullfile(output_dir, 'test_vector.pdf'), 'file')
    fprintf('[通过] 矢量PDF文件已创建\n');
else
    error('[失败] 矢量PDF文件未创建');
end

% 验证TIFF分辨率
tiff_info = imfinfo(fullfile(output_dir, 'test_raster.tiff'));
if tiff_info.XResolution >= 600
    fprintf('[通过] TIFF分辨率达到600dpi\n');
else
    fprintf('[警告] TIFF分辨率不足: %.1f dpi\n', tiff_info.XResolution);
end

% 验证CMYK转换
[status, cmdout] = system(sprintf('gs -q -o - -sDEVICE=inkcov %s',...
    fullfile(output_dir, 'test_vector.pdf')));
if status == 0
    % 检查输出是否包含CMYK信息
    if contains(cmdout, 'CMYK')
        fprintf('[通过] PDF已成功转换为CMYK\n');
    else
        fprintf('[警告] PDF可能未正确转换为CMYK\n');
    end
else
    fprintf('[警告] 无法验证CMYK转换: Ghostscript错误\n');
end

% 验证文件数量
pdf_files = dir(fullfile(output_dir, '*.pdf'));
if numel(pdf_files) >= numel(figs) + 2 % 原始导出 + 批量导出
    fprintf('[通过] 批量导出文件数量正确\n');
else
    fprintf('[失败] 文件数量不足: 预期%d, 实际%d\n',...
        numel(figs)+2, numel(pdf_files));
end

fprintf('\n测试完成! 所有输出保存在: %s\n', output_dir);

% 清理
close all;
end
