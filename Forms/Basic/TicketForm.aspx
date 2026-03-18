<%@ Page Title="Ticket Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TicketForm.aspx.cs" Inherits="Forms_Basic_TicketForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-ticket-perforated"></i> Ticket Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4 border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Ticket" /></h5>
  </div>
  <div class="card-body p-4">
    <asp:HiddenField ID="hfTicketId" runat="server" />
    <div class="row g-4">
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Select User *</label>
        <asp:DropDownList ID="ddlUser" runat="server" CssClass="form-select bg-light border-0 px-3 py-2" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlUser" InitialValue="" ErrorMessage="User required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Select Movie *</label>
        <asp:DropDownList ID="ddlMovie" runat="server" CssClass="form-select bg-light border-0 px-3 py-2" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlMovie" InitialValue="" ErrorMessage="Movie required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Theater Location *</label>
        <asp:DropDownList ID="ddlTheater" runat="server" CssClass="form-select bg-light border-0 px-3 py-2" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Cinema Hall *</label>
        <asp:DropDownList ID="ddlHall" runat="server" CssClass="form-select bg-light border-0 px-3 py-2" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Showtime *</label>
        <asp:DropDownList ID="ddlShow" runat="server" CssClass="form-select bg-light border-0 px-3 py-2" />
      </div>
      <div class="col-md-2">
        <label class="form-label fw-semibold text-muted small text-uppercase">Price (NPR) *</label>
        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="0.00" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrice" ErrorMessage="Price required" CssClass="text-danger small" Display="Dynamic" />
        <asp:RangeValidator runat="server" ControlToValidate="txtPrice" MinimumValue="0" MaximumValue="10000" Type="Double" ErrorMessage="0-10000" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Issue Date *</label>
        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" TextMode="Date" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDate" ErrorMessage="Date required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-2">
        <label class="form-label fw-semibold text-muted small text-uppercase">Booking Status</label>
        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select bg-light border-0 px-3 py-2">
          <asp:ListItem>Booked</asp:ListItem>
          <asp:ListItem>Paid</asp:ListItem>
          <asp:ListItem>Cancelled</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="col-md-2">
        <label class="form-label fw-semibold text-muted small text-uppercase">Payment</label>
        <asp:DropDownList ID="ddlPayment" runat="server" CssClass="form-select bg-light border-0 px-3 py-2">
          <asp:ListItem>Pending</asp:ListItem>
          <asp:ListItem>Completed</asp:ListItem>
          <asp:ListItem>Failed</asp:ListItem>
        </asp:DropDownList>
      </div>
    </div>
    <div class="mt-4 pt-2">
      <asp:Button ID="btnSave" runat="server" Text="Save Ticket" CssClass="btn btn-danger px-4 py-2 me-2 shadow-sm" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Reset Form" CssClass="btn btn-light px-4 py-2 text-muted" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark">Ticket Register</h5>
  </div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover mb-0"
        AutoGenerateColumns="false" DataKeyNames="TicketId" OnRowCommand="gvList_RowCommand" GridLines="None">
      <Columns>
        <asp:BoundField DataField="TicketId" HeaderText="ID" ItemStyle-CssClass="ps-4 text-muted small" HeaderStyle-CssClass="ps-4" />
        <asp:BoundField DataField="Username" HeaderText="User" ItemStyle-CssClass="fw-bold" />
        <asp:BoundField DataField="MovieTitle" HeaderText="Movie" />
        <asp:BoundField DataField="TheaterName" HeaderText="Theater" />
        <asp:BoundField DataField="ShowName" HeaderText="Show" />
        <asp:TemplateField HeaderText="Amount">
            <ItemTemplate><span class="fw-bold">Rs <%# Eval("TicketPrice", "{0:N0}") %></span></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="TicketDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
                <span class='badge rounded-pill px-3 <%# Eval("TicketStatus").ToString() == "Paid" ? "bg-success-subtle text-success" : (Eval("TicketStatus").ToString() == "Cancelled" ? "bg-danger-subtle text-danger" : "bg-warning-subtle text-warning") %>'>
                    <%# Eval("TicketStatus") %>
                </span>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="pe-4 text-end" HeaderStyle-CssClass="pe-4 text-end">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("TicketId") %>' CssClass="btn btn-sm btn-light text-warning me-1" CausesValidation="false" ToolTip="Edit"><i class="bi bi-pencil-square"></i></asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("TicketId") %>' CssClass="btn btn-sm btn-light text-danger" CausesValidation="false" OnClientClick="return confirm('Permanently delete this ticket?')" ToolTip="Delete"><i class="bi bi-trash3"></i></asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
