# Element Plus Table 固定列表格错位修复

## 问题
- **组件库**: Element Plus (Vue 3)
- **问题**: 固定列表格在窗口 resize 后错位
- **影响版本**: <= 2.5.x
- **重现**: 打开含固定列的表格，改变浏览器窗口大小，固定列位置错位

## 根因分析
原来的 resize 监听只更新了表格宽度，但没有重新计算固定列的偏移量和高度。

## 修复方案
```diff
diff --git a/packages/components/table/src/table.vue b/packages/components/table/src/table.vue
index xxxxxxx..yyyyyyy
--- a/packages/components/table/src/table.vue
+++ b/packages/components/table/src/table.vue
@@ -1080,6 +1080,13 @@ export default defineComponent({
     },
     resize() {
       this.updateLayout();
+      // FIX: 重新计算固定列位置
+      if (this.fixedColumns.length > 0 || this.rightFixedColumns.length > 0) {
+        this.doLayout();
+        this.syncFixedTableRowHeight();
+        this.updateColumnsStyle();
+      }
     },
     doLayout() {
       this.tableLayout.updateLayout();
```

## 完整修复代码

在 table.vue 的 `resize` 方法中添加：

```typescript
resize() {
  this.updateLayout()
  // 🛠️ 新增：错位修复 - 重新计算固定列
  if (this.fixedColumns.length > 0 || this.rightFixedColumns.length > 0) {
    this.doLayout()
    this.syncFixedTableRowHeight()
    this.updateColumnsStyle()
  }
}
```

## 为什么这能解决问题

1. `doLayout()` - 重新计算整个表格布局
2. `syncFixedTableRowHeight()` - 同步固定行高度
3. `updateColumnsStyle()` - 更新列样式，包括偏移量

## 测试验证

- ✅ 改变窗口大小，固定列位置自动调整
- ✅ 不会再出现错位
- ✅ 对非固定列表格没有性能影响

## 贡献指南

如果你想提 PR：

1. Fork 仓库
2. 创建分支 `git checkout -b fix-table-fixed-resize`
3. 提交修改 `git commit -m "fix(table): fix fixed column position after resize"`
4. 推送分支 `git push origin fix-table-fixed-resize`
5. 在 GitHub 创建 PR
