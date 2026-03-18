<%@ Page Title="Theater Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="TheaterForm.aspx.cs" Inherits="Forms_Basic_TheaterForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-building"></i> Theater (TheaterCityHall) Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4 border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Theater" /></h5>
  </div>
  <div class="card-body p-4">
    <asp:HiddenField ID="hfTheaterId" runat="server" />
    <div class="row g-4">
      <div class="col-md-5">
        <label class="form-label fw-semibold text-muted small text-uppercase">Theater Name *</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="e.g. City Center Mall" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-4">
        <label class="form-label fw-semibold text-muted small text-uppercase">Branch City *</label>
        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="e.g. Kathmandu" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" ErrorMessage="City is required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Facility Type</label>
        <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select bg-light border-0 px-3 py-2">
          <asp:ListItem>Multiplex</asp:ListItem>
          <asp:ListItem>Single Screen</asp:ListItem>
          <asp:ListItem>Drive-In</asp:ListItem>
          <asp:ListItem>IMAX</asp:ListItem>
        </asp:DropDownList>
      </div>
    </div>
    <div class="mt-4 pt-2">
      <asp:Button ID="btnSave" runat="server" Text="Save Theater" CssClass="btn btn-danger px-4 py-2 me-2 shadow-sm" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Reset Form" CssClass="btn btn-light px-4 py-2 text-muted" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark">Theater Network</h5>
  </div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover mb-0"
        AutoGenerateColumns="false" DataKeyNames="TheaterId" OnRowCommand="gvList_RowCommand" GridLines="None">
      <Columns>
        <asp:BoundField DataField="TheaterId" HeaderText="ID" ItemStyle-CssClass="ps-4 text-muted small" HeaderStyle-CssClass="ps-4" />
        <asp:BoundField DataField="TheaterName" HeaderText="Theater Name" ItemStyle-CssClass="fw-bold" />
        <asp:BoundField DataField="TheaterCity" HeaderText="City" />
        <asp:BoundField DataField="TheatreType" HeaderText="Category" />
        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="pe-4 text-end" HeaderStyle-CssClass="pe-4 text-end">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("TheaterId") %>' CssClass="btn btn-sm btn-light text-warning me-1" CausesValidation="false" ToolTip="Edit"><i class="bi bi-pencil-square"></i></asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("TheaterId") %>' CssClass="btn btn-sm btn-light text-danger" CausesValidation="false" OnClientClick="return confirm('Delete?')" ToolTip="Delete"><i class="bi bi-trash3"></i></asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
