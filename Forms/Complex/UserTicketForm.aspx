<%@ Page Title="User Ticket Report" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UserTicketForm.aspx.cs" Inherits="Forms_Complex_UserTicketForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-receipt"></i> User Ticket Report (Last 6 Months)</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false" />

<p class="text-muted small mb-4">Generate comprehensive ticket reports for specific users over a selected date range. Data reflects bookings from the last 6 months.</p>

<div class="card mb-4 border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark">Search Filters</h5>
  </div>
  <div class="card-body p-4">
    <div class="row g-4 align-items-end">
      <div class="col-md-4">
        <label class="form-label fw-semibold text-muted small text-uppercase mb-2">Select User Account</label>
        <asp:ListBox ID="lbUser" runat="server" CssClass="form-select bg-light border-0 px-3 py-2" Rows="5" SelectionMode="Single" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">From Date</label>
        <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" TextMode="Date" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">To Date</label>
        <asp:TextBox ID="txtTo" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" TextMode="Date" />
      </div>
      <div class="col-md-2">
        <asp:Button ID="btnSearch" runat="server" Text="Generate Report" CssClass="btn btn-danger w-100 shadow-sm py-2" OnClick="btnSearch_Click" CausesValidation="false" />
      </div>
    </div>
  </div>
</div>

<asp:Panel ID="pnlUser" runat="server" Visible="false" CssClass="card mb-4 border-0 shadow-sm overflow-hidden">
  <div class="card-header bg-danger text-white py-3 border-0">
    <h5 class="m-0 fw-bold">Customer Profile</h5>
  </div>
  <div class="card-body p-4">
    <div class="row g-4">
      <div class="col-md-3">
        <label class="fw-semibold text-muted small text-uppercase d-block mb-1">Username</label>
        <span class="fs-5 fw-bold text-dark"><asp:Label ID="lblUName" runat="server" /></span>
      </div>
      <div class="col-md-3">
        <label class="fw-semibold text-muted small text-uppercase d-block mb-1">Email Address</label>
        <span class="fw-bold"><asp:Label ID="lblUEmail" runat="server" /></span>
      </div>
      <div class="col-md-3">
        <label class="fw-semibold text-muted small text-uppercase d-block mb-1">Location</label>
        <span class="fw-bold"><asp:Label ID="lblUAddr" runat="server" /></span>
      </div>
      <div class="col-md-3">
        <label class="fw-semibold text-muted small text-uppercase d-block mb-1">Total Bookings</label>
        <span class="badge bg-danger rounded-pill px-3 py-2 fw-bold"><asp:Label ID="lblUTotal" runat="server" /> Tickets</span>
      </div>
    </div>
  </div>
</asp:Panel>

<asp:Panel ID="pnlTickets" runat="server" Visible="false">
  <div class="card border-0 shadow-sm">
    <div class="card-header bg-transparent py-3 border-bottom d-flex justify-content-between align-items-center">
      <h5 class="m-0 fw-bold text-dark">Ticket History</h5>
      <div class="text-end">
        <span class="text-muted small text-uppercase fw-semibold">Net Expenditure:</span>
        <span class="fs-5 fw-bold text-danger ms-2">NPR <asp:Label ID="lblTotalAmt" runat="server" /></span>
      </div>
    </div>
    <div class="card-body p-0">
      <asp:GridView ID="gvTickets" runat="server" CssClass="table table-hover mb-0"
          AutoGenerateColumns="false" EmptyDataText="No ticket records found for this user in the specified range." GridLines="None">
        <Columns>
          <asp:BoundField DataField="TicketId" HeaderText="ID" ItemStyle-CssClass="ps-4 text-muted small" HeaderStyle-CssClass="ps-4" />
          <asp:BoundField DataField="MovieTitle" HeaderText="Film Title" ItemStyle-CssClass="fw-bold" />
          <asp:BoundField DataField="TheaterName" HeaderText="Theater" />
          <asp:BoundField DataField="TheaterCity" HeaderText="Location" />
          <asp:BoundField DataField="HallType" HeaderText="Experience" />
          <asp:BoundField DataField="ShowName" HeaderText="Show" />
          <asp:BoundField DataField="ShowDate" HeaderText="Schedule" DataFormatString="{0:yyyy-MM-dd}" />
          <asp:TemplateField HeaderText="Fare">
            <ItemTemplate><span class="fw-bold text-dark">Rs <%# Eval("TicketPrice", "{0:N0}") %></span></ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
              <span class='badge rounded-pill px-3 <%# Eval("TicketStatus").ToString() == "Paid" ? "bg-success-subtle text-success" : (Eval("TicketStatus").ToString() == "Cancelled" ? "bg-danger-subtle text-danger" : "bg-warning-subtle text-warning") %>'>
                <%# Eval("TicketStatus") %>
              </span>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Payment" ItemStyle-CssClass="pe-4" HeaderStyle-CssClass="pe-4">
            <ItemTemplate>
              <span class='badge rounded-pill px-3 <%# Eval("PaymentStatus").ToString() == "Completed" ? "bg-success-subtle text-success" : (Eval("PaymentStatus").ToString() == "Failed" ? "bg-danger-subtle text-danger" : "bg-secondary-subtle text-secondary") %>'>
                <%# Eval("PaymentStatus") %>
              </span>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>
</asp:Panel>
</asp:Content>
