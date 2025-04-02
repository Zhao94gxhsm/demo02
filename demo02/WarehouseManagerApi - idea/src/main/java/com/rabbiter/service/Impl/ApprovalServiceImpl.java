package com.rabbiter.service.Impl;

import com.rabbiter.entity.Approval;
import com.rabbiter.mapper.ApprovalMapper;
import com.rabbiter.service.ApprovalService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class ApprovalServiceImpl extends ServiceImpl<ApprovalMapper, Approval> implements ApprovalService {
}