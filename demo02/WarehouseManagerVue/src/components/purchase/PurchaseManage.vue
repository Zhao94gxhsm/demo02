<template>
  <div>
    <h1>智能采购管理</h1>
    <el-button @click="openAddDialog">新增采购</el-button>
    <el-button @click="openUpdateDialog">更新采购</el-button>
    <el-table :data="purchaseList" stripe>
      <el-table-column prop="id" label="ID"></el-table-column>
      <el-table-column prop="goodsId" label="物品ID"></el-table-column>
      <el-table-column prop="planCount" label="计划采购数量"></el-table-column>
      <el-table-column prop="actualCount" label="实际入库数量"></el-table-column>
      <el-table-column prop="supplier" label="供应商"></el-table-column>
      <el-table-column prop="status" label="状态">
        <template #default="{ row }">
          <el-tag :type="getStatusTagType(row.status)">{{ getStatusText(row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间"></el-table-column>
      <el-table-column prop="expectedTime" label="预计到货时间"></el-table-column>
      <el-table-column prop="remark" label="备注"></el-table-column>
      <el-table-column label="操作">
        <template #default="{ row }">
          <el-button @click="deletePurchase(row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增采购对话框 -->
    <el-dialog :visible.sync="addDialogVisible" title="新增采购">
      <el-form :model="purchaseForm" label-width="120px">
        <el-form-item label="物品ID">
          <el-input v-model="purchaseForm.goodsId"></el-input>
        </el-form-item>
        <el-form-item label="计划采购数量">
          <el-input v-model="purchaseForm.planCount"></el-input>
        </el-form-item>
        <el-form-item label="供应商">
          <el-input v-model="purchaseForm.supplier"></el-input>
        </el-form-item>
        <el-form-item label="预计到货时间">
          <el-date-picker
            v-model="purchaseForm.expectedTime"
            type="datetime"
            placeholder="选择预计到货时间"
          ></el-date-picker>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="purchaseForm.remark"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="addDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="savePurchase">确定</el-button>
      </template>
    </el-dialog>

    <!-- 更新采购对话框 -->
    <el-dialog :visible.sync="updateDialogVisible" title="更新采购">
      <el-form :model="purchaseForm" label-width="120px">
        <el-form-item label="物品ID">
          <el-input v-model="purchaseForm.goodsId" disabled></el-input>
        </el-form-item>
        <el-form-item label="计划采购数量">
          <el-input v-model="purchaseForm.planCount"></el-input>
        </el-form-item>
        <el-form-item label="实际入库数量">
          <el-input v-model="purchaseForm.actualCount"></el-input>
        </el-form-item>
        <el-form-item label="供应商">
          <el-input v-model="purchaseForm.supplier"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="purchaseForm.status" placeholder="请选择状态">
            <el-option label="待采购" value="0"></el-option>
            <el-option label="采购中" value="1"></el-option>
            <el-option label="已完成" value="2"></el-option>
            <el-option label="已取消" value="3"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="预计到货时间">
          <el-date-picker
            v-model="purchaseForm.expectedTime"
            type="datetime"
            placeholder="选择预计到货时间"
          ></el-date-picker>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="purchaseForm.remark"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="updateDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="updatePurchase">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      purchaseList: [],
      addDialogVisible: false,
      updateDialogVisible: false,
      purchaseForm: {
        goodsId: null,
        planCount: null,
        actualCount: null,
        supplier: '',
        status: 0,
        expectedTime: null,
        remark: ''
      }
    };
  },
  mounted() {
    this.getPurchaseList();
  },
  methods: {
    getPurchaseList() {
      axios.get('/purchase')
        .then((res) => {
          if (res.data.code === 200) {
            this.purchaseList = res.data.data;
          }
        });
    },
    openAddDialog() {
      this.addDialogVisible = true;
      this.purchaseForm = {
        goodsId: null,
        planCount: null,
        actualCount: null,
        supplier: '',
        status: 0,
        expectedTime: null,
        remark: ''
      };
    },
    savePurchase() {
      axios.post('/purchase', this.purchaseForm)
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '新增成功！',
              type: 'success'
            });
            this.addDialogVisible = false;
            this.getPurchaseList();
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
      this.purchaseForm = { ...row };
    },
    updatePurchase() {
      axios.put('/purchase', this.purchaseForm)
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '更新成功！',
              type: 'success'
            });
            this.updateDialogVisible = false;
            this.getPurchaseList();
          } else {
            this.$message({
              message: '更新失败！',
              type: 'error'
            });
          }
        });
    },
    deletePurchase(id) {
      this.$confirm('确定要删除该采购记录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        axios.delete(`/purchase/${id}`)
          .then((res) => {
            if (res.data.code === 200) {
              this.$message({
                message: '删除成功！',
                type: 'success'
              });
              this.getPurchaseList();
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
    getStatusText(status) {
      switch (status) {
        case 0:
          return '待采购';
        case 1:
          return '采购中';
        case 2:
          return '已完成';
        case 3:
          return '已取消';
        default:
          return '';
      }
    },
    getStatusTagType(status) {
      switch (status) {
        case 0:
          return 'info';
        case 1:
          return 'primary';
        case 2:
          return 'success';
        case 3:
          return 'danger';
        default:
          return '';
      }
    }
  }
};
</script>   