<%@ Page Title="Hall Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="HallForm.aspx.cs" Inherits="Forms_Basic_HallForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-grid"></i> Hall Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4 border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Hall" /></h5>
  </div>
  <div class="card-body p-4">
    <asp:HiddenField ID="hfHallId" runat="server" />
    <div class="row g-4">
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Hall Capacity *</label>
        <asp:TextBox ID="txtCapacity" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="e.g. 150" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCapacity" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
        <asp:RangeValidator runat="server" ControlToValidate="txtCapacity" MinimumValue="1" MaximumValue="2000" Type="Integer" ErrorMessage="1-2000" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Hall Type</label>
        <asp:DropDownList ID="ddlHallType" runat="server" CssClass="form-select bg-light border-0 px-3 py-2">
          <asp:ListItem>Standard</asp:ListItem>
          <asp:ListItem>Premium</asp:ListItem>
          <asp:ListItem>IMAX</asp:ListItem>
          <asp:ListItem>4DX</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Floor No</label>
        <asp:TextBox ID="txtFloor" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" Text="1" />
        <asp:RangeValidator runat="server" ControlToValidate="txtFloor" MinimumValue="0" MaximumValue="20" Type="Integer" ErrorMessage="0-20" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Total Seats *</label>
        <asp:TextBox ID="txtSeats" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="e.g. 150" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSeats" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
        <asp:RangeValidator runat="server" ControlToValidate="txtSeats" MinimumValue="1" MaximumValue="2000" Type="Integer" ErrorMessage="1-2000" CssClass="text-danger small" Display="Dynamic" />
      </div>
    </div>
    <div class="mt-4 pt-2">
      <asp:Button ID="btnSave" runat="server" Text="Save Hall" CssClass="btn btn-danger px-4 py-2 me-2 shadow-sm" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Reset Form" CssClass="btn btn-light px-4 py-2 text-muted" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark">Hall Configuration</h5>
  </div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover mb-0"
        AutoGenerateColumns="false" DataKeyNames="HallId" OnRowCommand="gvList_RowCommand" GridLines="None">
      <Columns>
        <asp:BoundField DataField="HallId" HeaderText="ID" ItemStyle-CssClass="ps-4 text-muted small" HeaderStyle-CssClass="ps-4" />
        <asp:BoundField DataField="HallCapacity" HeaderText="Capacity" ItemStyle-CssClass="fw-bold" />
        <asp:BoundField DataField="HallType" HeaderText="Type" />
        <asp:BoundField DataField="FloorNo" HeaderText="Floor" />
        <asp:BoundField DataField="TotalSeats" HeaderText="Seats" />
        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="pe-4 text-end" HeaderStyle-CssClass="pe-4 text-end">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("HallId") %>' CssClass="btn btn-sm btn-light text-warning me-1" CausesValidation="false" ToolTip="Edit"><i class="bi bi-pencil-square"></i></asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("HallId") %>' CssClass="btn btn-sm btn-light text-danger" CausesValidation="false" OnClientClick="return confirm('Delete?')" ToolTip="Delete"><i class="bi bi-trash3"></i></asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
