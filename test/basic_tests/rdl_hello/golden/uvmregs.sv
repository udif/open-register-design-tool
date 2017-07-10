//   Ordt 170710.01 autogenerated file 
//   Input: ./rdl_hello/test.rdl
//   Parms: ./rdl_hello/test.parms
//   Date: Mon Jul 10 15:04:07 EDT 2017
//

import uvm_pkg::*;
import ordt_uvm_reg_pkg::*;

// Register a_reg
class reg_foo_bar_a_reg extends uvm_reg_rdl;
  string m_rdl_tag;
  rand uvm_reg_field_rdl fld1;
  rand uvm_reg_field_rdl fld2;
  
  function new(string name = "reg_foo_bar_a_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction: new
  
  virtual function void build();
    string rdl_reg_name;
    this.fld1 = new("fld1");
    this.fld1.set_rdl_access_info(1, 1, 1, 1, 1, 0);
    this.fld1.configure(this, 10, 0, "RW", 1, 10'h0, 1, 1, 0);
    this.fld2 = new("fld2");
    this.fld2.set_rdl_access_info(1, 1, 1, 0, 0, 0);
    this.fld2.configure(this, 1, 15, "RW", 0, 0, 1, 1, 0);
    void'(this.fld2.has_reset(.delete(1)));
    
    rdl_reg_name = get_rdl_name("rg_");
    add_hdl_path_slice({rdl_reg_name, "fld1"}, 0, 10);
    add_hdl_path_slice({rdl_reg_name, "fld2"}, 15, 1);
  endfunction: build
  
endclass : reg_foo_bar_a_reg

// bar registers
class block_foo_bar extends uvm_reg_block_rdl;
  rand reg_foo_bar_a_reg a_reg[2];
  
  function new(string name = "block_foo_bar");
    super.new(name);
  endfunction: new
  
  virtual function void build();
    this.default_map = create_map("", 0, 4, UVM_LITTLE_ENDIAN, 1);
    foreach (this.a_reg[i]) begin
      this.a_reg[i] = new($psprintf("a_reg [%0d]",i));
      this.a_reg[i].configure(this, null, "");
      this.a_reg[i].set_rdl_tag($psprintf("a_reg_%0d_",i));
      this.a_reg[i].set_reg_test_info(0, 0, 0);
      this.a_reg[i].build();
      this.default_map.add_reg(this.a_reg[i], `UVM_REG_ADDR_WIDTH'h0+i*`UVM_REG_ADDR_WIDTH'h4, "RW", 0);
    end
  endfunction: build
  
  `uvm_object_utils(block_foo_bar)
endclass : block_foo_bar

// Base block
class block_foo extends uvm_reg_block_rdl;
  rand block_foo_bar bar;
  
  function new(string name = "block_foo");
    super.new(name);
  endfunction: new
  
  virtual function void build();
    this.default_map = create_map("", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);
    this.set_rdl_address_map(1);
    this.set_rdl_address_map_hdl_path({`FOO_PIO_INSTANCE_PATH, ".pio_logic"});
    this.bar = block_foo_bar::type_id::create("bar",, get_full_name());
    this.bar.configure(this, "");
    this.bar.set_rdl_tag("bar_");
    this.bar.build();
    this.default_map.add_submap(this.bar.default_map, `UVM_REG_ADDR_WIDTH'h0);
    set_hdl_path_root({`FOO_PIO_INSTANCE_PATH, ".pio_logic"});
    this.add_callbacks();
  endfunction: build
  
  `uvm_object_utils(block_foo)
endclass : block_foo
