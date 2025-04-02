<template>
  <div>
    <h1>智能库存预警管理</h1>
    <el-button @click="openAddDialog">新增预警</el-button>
    <el-button @click="openUpdateDialog">处理预警</el-button>
    <el-table :data="warningList" stripe>
      <el-table-column prop="id" label="ID"></el-table-column>
      <el-table-column prop="goodsId" label="物品ID"></el-table-column>
      <el-table-column prop="warningType" label="预警类型">
        <template #default="{ row }">
          {{ getWarningTypeText(row.warningType) }}
        </template>
      </el-table-column>
      <el-table-column prop="threshold" label="预警阈值"></el-table-column>
      <el-table-column prop="currentCount" label="当前数量"></el-table-column>
      <el-table-column prop="occurTime" label="发生时间"></el-table-column>
      <el-table-column prop="isHandled" label="是否处理">
        <template #default="{ row }">
          <el-tag :type="getIsHandledTagType(row.isHandled)">{{ getIsHandledText(row.isHandled) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template #default="{ row }">
          <el-button @click="deleteWarning(row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增预警对话框 -->
    <el-dialog :visible.sync="addDialogVisible" title="新增预警">
      <el-form :model="warningForm" label-width="120px">
        <el-form-item label="物品ID">
          <el-input v-model="warningForm.goodsId"></el-input>
        </el-form-item>
        <el-form-item label="预警类型">
          <el-select v-model="warningForm.warningType" placeholder="请选择预警类型">
            <el-option label="库存不足" value="1"></el-option>
            <el-option label="库存过多" value="2"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="预警阈值">
          <el-input v-model="warningForm.threshold"></el-input>
        </el-form-item>
        <el-form-item label="当前数量">
          <el-input v-model="warningForm.currentCount"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="addDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveWarning">确定</el-button>
      </template>
    </el-dialog>

    <!-- 处理预警对话框 -->
    <el-dialog :visible.sync="updateDialogVisible" title="处理预警">
      <el-form :model="warningForm" label-width="120px">
        <el-form-item label="物品ID">
          <el-input v-model="warningForm.goodsId" disabled></el-input>
        </el-form-item>
        <el-form-item label="预警类型">
          <el-input :value="getWarningTypeText(warningForm.warningType)" disabled></el-input>
        </el-form-item>
        <el-form-item label="预警阈值">
          <el-input v-model="warningForm.threshold" disabled></el-input>
        </el-form-item>
        <el-form-item label="当前数量">
          <el-input v-model="warningForm.currentCount"></el-input>
        </el-form-item>
        <el-form-item label="是否处理">
          <el-select v-model="warningForm.isHandled" placeholder="请选择处理状态">
            <el-option label="未处理" value="0"></el-option>
            <el-option label="已处理" value="1"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="updateDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="updateWarning">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      warningList: [],
      addDialogVisible: false,
      updateDialogVisible: false,
      warningForm: {
        goodsId: null,
        warningType: null,
        threshold: null,
        currentCount: null,
        isHandled: 0
      }
    };
  },
  mounted() {
    this.getWarningList();
  },
  methods: {
    getWarningList() {
      axios.get('/inventoryWarning')
        .then((res) => {
          if (res.data.code === 200) {
            this.warningList = res.data.data;
          }
        });
    },
    openAddDialog() {
      this.addDialogVisible = true;
      this.warningForm = {
        goodsId: null,
        warningType: null,
        threshold: null,
        currentCount: null,
        isHandled: 0
      };
    },
    saveWarning() {
      axios.post('/inventoryWarning', this.warningForm)
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '新增成功！',
              type: 'success'
            });
            this.addDialogVisible = false;
            this.getWarningList();
          } else {
            this.$message({
              message: '新增失败！',
              type: 'error'
            });
          }
        });
    },
    openUpdateDialog(row) {
      this.updateDialogVisible = true;
      this.warningForm = { ...row };
    },
    updateWarning() {
      axios.put('/inventoryWarning', this.warningForm)
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '处理成功！',
              type: 'success'
            });
            this.updateDialogVisible = false;
            this.getWarningList();
          } else {
            this.$message({
              message: '处理失败！',
              type: 'error'
            });
          }
        });
    },
    deleteWarning(id) {
      this.$confirm('确定要删除该预警记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        axios.delete(`/inventoryWarning/${id}`)
          .then((res) => {
            if (res.data.code === 200) {
              this.$message({
                message: '删除成功！',
                type: 'success'
              });
              this.getWarningList();
            } else {
              this.$message({
                message: '删除失败！',
                type: 'error'
              });
            }
          });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    getWarningTypeText(warningType) {
      switch (warningType) {
        case 1:
          return '库存不足';
        case 2:
          return '库存过多';
        default:
          return '';
      }
    },
    getIsHandledText(isHandled) {
      return isHandled === 0 ? '未处理' : '已处理';
    },
    getIsHandledTagType(isHandled) {
      return isHandled === 0 ? 'danger' : 'success';
    }
  }
};
</script>    