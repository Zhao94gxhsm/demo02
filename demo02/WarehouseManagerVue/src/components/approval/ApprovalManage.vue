<template>
  <div>
    <h1>智能审批管理</h1>
    <el-button @click="openAddDialog">新增审批</el-button>
    <el-button @click="openUpdateDialog">处理审批</el-button>
    <el-table :data="approvalList" stripe>
      <el-table-column prop="id" label="ID"></el-table-column>
      <el-table-column prop="goodsId" label="物品ID"></el-table-column>
      <el-table-column prop="purchase_id" label="采购计划ID"></el-table-column>
      <el-table-column prop="userId" label="申请人ID"></el-table-column>
      <el-table-column prop="adminId" label="审批人ID"></el-table-column>
      <el-table-column prop="actionType" label="操作类型">
        <template #default="{ row }">
          {{ row.actionType === 1 ? '出库' : row.actionType === 2 ? '入库' : '采购' }}
        </template>
      </el-table-column>
      <el-table-column prop="requestCount" label="申请数量"></el-table-column>
      <el-table-column prop="status" label="状态">
        <template #default="{ row }">
          <el-tag :type="getStatusTagType(row.status)">{{ getStatusText(row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="applyTime" label="申请时间"></el-table-column>
      <el-table-column prop="approveTime" label="审批时间"></el-table-column>
      <el-table-column prop="remark" label="备注"></el-table-column>
      <el-table-column label="操作">
        <template #default="{ row }">
          <el-button @click="deleteApproval(row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 新增审批对话框 -->
    <el-dialog :visible.sync="addDialogVisible" title="新增审批">
      <el-form :model="approvalForm" label-width="120px">
        <el-form-item label="物品ID">
          <el-input v-model="approvalForm.goodsId"></el-input>
        </el-form-item>
        <el-form-item label="申请人ID">
          <el-input v-model="approvalForm.userId"></el-input>
        </el-form-item>
        <el-form-item label="操作类型">
          <el-select v-model="approvalForm.actionType" placeholder="请选择操作类型">
            <el-option label="出库" value="1"></el-option>
            <el-option label="入库" value="2"></el-option>
            <el-option label="采购" value="3"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="申请数量">
          <el-input v-model="approvalForm.requestCount"></el-input>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="approvalForm.remark"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="addDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveApproval">确定</el-button>
      </template>
    </el-dialog>

    <!-- 处理审批对话框 -->
    <el-dialog :visible.sync="updateDialogVisible" title="处理审批">
      <el-form :model="approvalForm" label-width="120px">
        <el-form-item label="状态">
          <el-select v-model="approvalForm.status" placeholder="请选择状态">
            <el-option label="待审批" value="0"></el-option>
            <el-option label="已批准" value="1"></el-option>
            <el-option label="已拒绝" value="2"></el-option>
            <el-option label="已完成" value="3"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="approvalForm.remark"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="updateDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="updateApproval">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      approvalList: [],
      addDialogVisible: false,
      updateDialogVisible: false,
      approvalForm: {}
    };
  },
  mounted() {
    this.getApprovalList();
  },
  methods: {
    getApprovalList() {
      axios.get('/approval')
        .then((res) => {
          if (res.data.code === 200) {
            this.approvalList = res.data.data;
          }
        });
    },
    openAddDialog() {
      this.addDialogVisible = true;
      this.approvalForm = {};
    },
    saveApproval() {
      axios.post('/approval', this.approvalForm)
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '新增成功！',
              type: 'success'
            });
            this.addDialogVisible = false;
            this.getApprovalList();
          } else {
            this.$message({
              message: '新增失败！',
              type: 'error'
            });
          }
        });
    },
    openUpdateDialog() {
      if (this.approvalList.length > 0) {
        this.updateDialogVisible = true;
        this.approvalForm = { ...this.approvalList[0] };
      } else {
        this.$message({
          message: '没有可处理的记录！',
          type: 'warning'
        });
      }
    },
    updateApproval() {
      axios.put('/approval', this.approvalForm)
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '处理成功！',
              type: 'success'
            });
            this.updateDialogVisible = false;
            this.getApprovalList();
          } else {
            this.$message({
              message: '处理失败！',
              type: 'error'
            });
          }
        });
    },
    deleteApproval(id) {
      axios.delete(`/approval/${id}`)
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '删除成功！',
              type: 'success'
            });
            this.getApprovalList();
          } else {
            this.$message({
              message: '删除失败！',
              type: 'error'
            });
          }
        });
    },
    getStatusText(status) {
      switch (status) {
        case 0:
          return '待审批';
        case 1:
          return '已批准';
        case 2:
          return '已拒绝';
        case 3:
          return '已完成';
        default:
          return '';
      }
    },
    getStatusTagType(status) {
      switch (status) {
        case 0:
          return 'info';
        case 1:
          return 'success';
        case 2:
          return 'danger';
        case 3:
          return 'warning';
        default:
          return '';
      }
    }
  }
};
</script>    