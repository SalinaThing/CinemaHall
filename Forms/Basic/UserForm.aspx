<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UserForm.aspx.cs" Inherits="Forms_Basic_UserForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-people"></i> User Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4">
  <div class="card-header">
    <asp:Label ID="lblFormTitle" runat="server" Text="Add New User" />
  </div>
  <div class="card-body">
    <asp:HiddenField ID="hfUserId" runat="server" />
    <div class="row g-3">
      <div class="col-md-6">
        <label class="form-label">Username *</label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-6">
        <label class="form-label">Email *</label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="\S+@\S+\.\S+" ErrorMessage="Invalid email" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-6">
        <label class="form-label">Password *</label>
        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-6">
        <label class="form-label">Address</label>
        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" />
      </div>
    </div>
    <div class="mt-3">
      <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-danger me-2" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card">
  <div class="card-header">User List</div>
  <div class="card-body p-0">
    <asp:GridView ID="gvUsers" runat="server" CssClass="table table-hover table-sm mb-0"
        AutoGenerateColumns="false" DataKeyNames="UserId"
        OnRowCommand="gvUsers_RowCommand">
      <Columns>
        <asp:BoundField DataField="UserId" HeaderText="ID" />
        <asp:BoundField DataField="Username" HeaderText="Username" />
        <asp:BoundField DataField="UserEmail" HeaderText="Email" />
        <asp:BoundField DataField="Address" HeaderText="Address" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("UserId") %>' CssClass="btn btn-sm btn-warning btn-action"><i class="bi bi-pencil"></i> Edit</asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("UserId") %>' CssClass="btn btn-sm btn-danger btn-action" OnClientClick="return confirm('Delete this user?')"><i class="bi bi-trash"></i> Delete</asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
