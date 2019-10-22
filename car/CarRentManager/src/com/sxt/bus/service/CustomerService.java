package com.sxt.bus.service;

import java.util.List;

import com.sxt.bus.domain.Customer;
import com.sxt.bus.vo.CustomerVo;
import com.sxt.sys.utils.DataGridView;

public interface CustomerService {

	DataGridView queryAllCustomers(CustomerVo customerVo);

	void addCustomer(CustomerVo customerVo);

	void updateCustomer(CustomerVo customerVo);

	void deleteCustomer(CustomerVo customerVo);

	Customer queryCustomerByIdentity(String identity);

	List<Customer> queryCustomers(CustomerVo customerVo);

}
