package com.sxt.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.bus.domain.Customer;
import com.sxt.bus.mapper.CustomerMapper;
import com.sxt.bus.service.CustomerService;
import com.sxt.bus.vo.CustomerVo;
import com.sxt.sys.utils.DataGridView;

@Service
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CustomerMapper customerMapper;

	@Override
	public DataGridView queryAllCustomers(CustomerVo customerVo) {
		DataGridView dataGridView=new DataGridView();
		Page<Customer> page=PageHelper.startPage(customerVo.getPage(), customerVo.getRows());
		List<Customer> list=this.customerMapper.queryAllCustomer(customerVo);
		dataGridView.setTotal(page.getTotal());
		dataGridView.setRows(list);
		return dataGridView;
	}

	@Override
	public void addCustomer(CustomerVo customerVo) {
		this.customerMapper.insert(customerVo);
	}

	@Override
	public void updateCustomer(CustomerVo customerVo) {
		this.customerMapper.updateByPrimaryKey(customerVo);
	}

	@Override
	public void deleteCustomer(CustomerVo customerVo) {
		this.customerMapper.deleteByPrimaryKey(customerVo.getIdentity());
	}

	@Override
	public Customer queryCustomerByIdentity(String identity) {
		return this.customerMapper.selectByPrimaryKey(identity);
	}

	@Override
	public List<Customer> queryCustomers(CustomerVo customerVo) {
		return this.customerMapper.queryAllCustomer(customerVo);
	}
	
}
