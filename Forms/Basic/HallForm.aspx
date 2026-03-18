<%@ Page Title="Hall Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="HallForm.aspx.cs" Inherits="Forms_Basic_HallForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-grid"></i> Hall Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4">
  <div class="card-header"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Hall" /></div>
  <div class="card-body">
    <asp:HiddenField ID="hfHallId" runat="server" />
    <div class="row g-3">
      <div class="col-md-3">
        <label class="form-label">Hall Capacity *</label>
        <asp:TextBox ID="txtCapacity" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCapacity" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
        <asp:RangeValidator runat="server" ControlToValidate="txtCapacity" MinimumValue="1" MaximumValue="2000" Type="Integer" ErrorMessage="1-2000" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label">Hall Type</label>
        <asp:DropDownList ID="ddlHallType" runat="server" CssClass="form-select">
          <asp:ListItem>Standard</asp:ListItem>
          <asp:ListItem>Premium</asp:ListItem>
          <asp:ListItem>IMAX</asp:ListItem>
          <asp:ListItem>4DX</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="col-md-3">
        <label class="form-label">Floor No</label>
        <asp:TextBox ID="txtFloor" runat="server" CssClass="form-control" Text="1" />
        <asp:RangeValidator runat="server" ControlToValidate="txtFloor" MinimumValue="0" MaximumValue="20" Type="Integer" ErrorMessage="0-20" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label">Total Seats *</label>
        <asp:TextBox ID="txtSeats" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSeats" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
        <asp:RangeValidator runat="server" ControlToValidate="txtSeats" MinimumValue="1" MaximumValue="2000" Type="Integer" ErrorMessage="1-2000" CssClass="text-danger small" Display="Dynamic" />
      </div>
    </div>
    <div class="mt-3">
      <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-danger me-2" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card">
  <div class="card-header">Hall List</div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover table-sm mb-0"
        AutoGenerateColumns="false" DataKeyNames="HallId" OnRowCommand="gvList_RowCommand">
      <Columns>
        <asp:BoundField DataField="HallId" HeaderText="ID" />
        <asp:BoundField DataField="HallCapacity" HeaderText="Capacity" />
        <asp:BoundField DataField="HallType" HeaderText="Type" />
        <asp:BoundField DataField="FloorNo" HeaderText="Floor" />
        <asp:BoundField DataField="TotalSeats" HeaderText="Total Seats" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("HallId") %>' CssClass="btn btn-sm btn-warning btn-action"><i class="bi bi-pencil"></i> Edit</asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("HallId") %>' CssClass="btn btn-sm btn-danger btn-action" OnClientClick="return confirm('Delete?')"><i class="bi bi-trash"></i> Delete</asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
