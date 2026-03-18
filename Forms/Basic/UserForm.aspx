<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UserForm.aspx.cs" Inherits="Forms_Basic_UserForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-people"></i> User Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4 border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark"><asp:Label ID="lblFormTitle" runat="server" Text="Add New User" /></h5>
  </div>
  <div class="card-body p-4">
    <asp:HiddenField ID="hfUserId" runat="server" />
    <div class="row g-4">
      <div class="col-md-6">
        <label class="form-label fw-semibold text-muted small text-uppercase">Username *</label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="Enter username" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-6">
        <label class="form-label fw-semibold text-muted small text-uppercase">Email Address *</label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="name@example.com" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="text-danger small" Display="Dynamic" />
        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="\S+@\S+\.\S+" ErrorMessage="Please enter a valid email" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-6">
        <label class="form-label fw-semibold text-muted small text-uppercase">Security Password *</label>
        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" TextMode="Password" placeholder="••••••••" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-6">
        <label class="form-label fw-semibold text-muted small text-uppercase">Resident Address</label>
        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="Enter full address" />
      </div>
    </div>
    <div class="mt-4 pt-2">
      <asp:Button ID="btnSave" runat="server" Text="Save Account" CssClass="btn btn-danger px-4 py-2 me-2 shadow-sm" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Reset Form" CssClass="btn btn-light px-4 py-2 text-muted" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark">User Directory</h5>
  </div>
  <div class="card-body p-0">
    <asp:GridView ID="gvUsers" runat="server" CssClass="table table-hover mb-0"
        AutoGenerateColumns="false" DataKeyNames="UserId"
        OnRowCommand="gvUsers_RowCommand" GridLines="None">
      <Columns>
        <asp:BoundField DataField="UserId" HeaderText="ID" ItemStyle-CssClass="ps-4 text-muted small" HeaderStyle-CssClass="ps-4" />
        <asp:BoundField DataField="Username" HeaderText="Username" ItemStyle-CssClass="fw-bold" />
        <asp:BoundField DataField="UserEmail" HeaderText="Email" />
        <asp:BoundField DataField="Address" HeaderText="Address" />
        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="pe-4 text-end" HeaderStyle-CssClass="pe-4 text-end">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("UserId") %>' CssClass="btn btn-sm btn-light text-warning me-1" CausesValidation="false" ToolTip="Edit User"><i class="bi bi-pencil-square"></i></asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("UserId") %>' CssClass="btn btn-sm btn-light text-danger" CausesValidation="false" OnClientClick="return confirm('Permanently delete this user?')" ToolTip="Delete User"><i class="bi bi-trash3"></i></asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
