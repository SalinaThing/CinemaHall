<%@ Page Title="Show Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="ShowForm.aspx.cs" Inherits="Forms_Basic_ShowForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-calendar3"></i> Show (Showtimes) Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4 border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Show" /></h5>
  </div>
  <div class="card-body p-4">
    <asp:HiddenField ID="hfShowId" runat="server" />
    <div class="row g-4">
      <div class="col-md-4">
        <label class="form-label fw-semibold text-muted small text-uppercase">Show Identity *</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="e.g. Morning Screening" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-4">
        <label class="form-label fw-semibold text-muted small text-uppercase">Scheduled Date *</label>
        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" TextMode="Date" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDate" ErrorMessage="Date is required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-2">
        <label class="form-label fw-semibold text-muted small text-uppercase">Session Time</label>
        <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select bg-light border-0 px-3 py-2">
          <asp:ListItem>Morning</asp:ListItem>
          <asp:ListItem>Day</asp:ListItem>
          <asp:ListItem>Evening</asp:ListItem>
          <asp:ListItem>Night</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="col-md-2">
        <label class="form-label fw-semibold text-muted small text-uppercase">Availability</label>
        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select bg-light border-0 px-3 py-2">
          <asp:ListItem>Active</asp:ListItem>
          <asp:ListItem>Cancelled</asp:ListItem>
          <asp:ListItem>Completed</asp:ListItem>
        </asp:DropDownList>
      </div>
    </div>
    <div class="mt-4 pt-2">
      <asp:Button ID="btnSave" runat="server" Text="Save Schedule" CssClass="btn btn-danger px-4 py-2 me-2 shadow-sm" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Reset Form" CssClass="btn btn-light px-4 py-2 text-muted" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark">Screening Calendar</h5>
  </div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover mb-0"
        AutoGenerateColumns="false" DataKeyNames="ShowId" OnRowCommand="gvList_RowCommand" GridLines="None">
      <Columns>
        <asp:BoundField DataField="ShowId" HeaderText="ID" ItemStyle-CssClass="ps-4 text-muted small" HeaderStyle-CssClass="ps-4" />
        <asp:BoundField DataField="ShowName" HeaderText="Show Name" ItemStyle-CssClass="fw-bold" />
        <asp:BoundField DataField="ShowDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="ShowType" HeaderText="Timing" />
        <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
                <span class='badge rounded-pill px-3 <%# Eval("ShowStatus").ToString() == "Active" ? "bg-success-subtle text-success" : (Eval("ShowStatus").ToString() == "Cancelled" ? "bg-danger-subtle text-danger" : "bg-secondary-subtle text-secondary") %>'>
                    <%# Eval("ShowStatus") %>
                </span>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="pe-4 text-end" HeaderStyle-CssClass="pe-4 text-end">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("ShowId") %>' CssClass="btn btn-sm btn-light text-warning me-1" CausesValidation="false" ToolTip="Edit"><i class="bi bi-pencil-square"></i></asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("ShowId") %>' CssClass="btn btn-sm btn-light text-danger" CausesValidation="false" OnClientClick="return confirm('Delete schedule?')" ToolTip="Delete"><i class="bi bi-trash3"></i></asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
