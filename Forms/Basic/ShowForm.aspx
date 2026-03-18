<%@ Page Title="Show Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ShowForm.aspx.cs" Inherits="Forms_Basic_ShowForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-calendar3"></i> Show (Showtimes) Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4">
  <div class="card-header"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Show" /></div>
  <div class="card-body">
    <asp:HiddenField ID="hfShowId" runat="server" />
    <div class="row g-3">
      <div class="col-md-4">
        <label class="form-label">Show Name *</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-4">
        <label class="form-label">Show Date *</label>
        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDate" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-2">
        <label class="form-label">Show Type</label>
        <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select">
          <asp:ListItem>Morning</asp:ListItem>
          <asp:ListItem>Day</asp:ListItem>
          <asp:ListItem>Evening</asp:ListItem>
          <asp:ListItem>Night</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="col-md-2">
        <label class="form-label">Status</label>
        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
          <asp:ListItem>Active</asp:ListItem>
          <asp:ListItem>Cancelled</asp:ListItem>
          <asp:ListItem>Completed</asp:ListItem>
        </asp:DropDownList>
      </div>
    </div>
    <div class="mt-3">
      <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-danger me-2" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card">
  <div class="card-header">Show List</div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover table-sm mb-0"
        AutoGenerateColumns="false" DataKeyNames="ShowId" OnRowCommand="gvList_RowCommand">
      <Columns>
        <asp:BoundField DataField="ShowId" HeaderText="ID" />
        <asp:BoundField DataField="ShowName" HeaderText="Name" />
        <asp:BoundField DataField="ShowDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="ShowType" HeaderText="Type" />
        <asp:BoundField DataField="ShowStatus" HeaderText="Status" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("ShowId") %>' CssClass="btn btn-sm btn-warning btn-action"><i class="bi bi-pencil"></i> Edit</asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("ShowId") %>' CssClass="btn btn-sm btn-danger btn-action" OnClientClick="return confirm('Delete?')"><i class="bi bi-trash"></i> Delete</asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
