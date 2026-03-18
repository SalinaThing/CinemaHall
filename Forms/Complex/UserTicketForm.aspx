<%@ Page Title="User Ticket Report" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UserTicketForm.aspx.cs" Inherits="Forms_Complex_UserTicketForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-receipt"></i> User Ticket Report (Last 6 Months)</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false" />

<div class="card mb-4">
  <div class="card-header bg-dark text-white">Filter</div>
  <div class="card-body">
    <div class="row g-3 align-items-end">
      <div class="col-md-4">
        <label class="form-label">Select User</label>
        <asp:ListBox ID="lbUser" runat="server" CssClass="form-select" Rows="5" SelectionMode="Single" />
      </div>
      <div class="col-md-3">
        <label class="form-label">From Date</label>
        <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control" TextMode="Date" />
      </div>
      <div class="col-md-3">
        <label class="form-label">To Date</label>
        <asp:TextBox ID="txtTo" runat="server" CssClass="form-control" TextMode="Date" />
      </div>
      <div class="col-md-2">
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-danger w-100" OnClick="btnSearch_Click" CausesValidation="false" />
      </div>
    </div>
  </div>
</div>

<!-- User Details Panel -->
<asp:Panel ID="pnlUser" runat="server" Visible="false" CssClass="card mb-4">
  <div class="card-header">User Details</div>
  <div class="card-body">
    <div class="row">
      <div class="col-md-3"><strong>Username:</strong> <asp:Label ID="lblUName" runat="server" /></div>
      <div class="col-md-3"><strong>Email:</strong> <asp:Label ID="lblUEmail" runat="server" /></div>
      <div class="col-md-3"><strong>Address:</strong> <asp:Label ID="lblUAddr" runat="server" /></div>
      <div class="col-md-3"><strong>Total Tickets:</strong> <asp:Label ID="lblUTotal" runat="server" /></div>
    </div>
  </div>
</asp:Panel>

<!-- Ticket Results -->
<asp:Panel ID="pnlTickets" runat="server" Visible="false">
  <div class="card">
    <div class="card-header">Ticket Details</div>
    <div class="card-body p-0">
      <asp:GridView ID="gvTickets" runat="server" CssClass="table table-hover table-sm mb-0"
          AutoGenerateColumns="false" EmptyDataText="No tickets found.">
        <Columns>
          <asp:BoundField DataField="TicketId" HeaderText="Ticket ID" />
          <asp:BoundField DataField="MovieTitle" HeaderText="Movie" />
          <asp:BoundField DataField="TheaterName" HeaderText="Theater" />
          <asp:BoundField DataField="TheaterCity" HeaderText="City" />
          <asp:BoundField DataField="HallType" HeaderText="Hall Type" />
          <asp:BoundField DataField="ShowName" HeaderText="Show" />
          <asp:BoundField DataField="ShowDate" HeaderText="Show Date" DataFormatString="{0:yyyy-MM-dd}" />
          <asp:BoundField DataField="TicketPrice" HeaderText="Price (NPR)" DataFormatString="{0:N0}" />
          <asp:BoundField DataField="TicketDate" HeaderText="Booked On" DataFormatString="{0:yyyy-MM-dd}" />
          <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
              <span class='badge <%# GetStatusBadge(Eval("TicketStatus").ToString()) %>'><%# Eval("TicketStatus") %></span>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Payment">
            <ItemTemplate>
              <span class='badge <%# GetPaymentBadge(Eval("PaymentStatus").ToString()) %>'><%# Eval("PaymentStatus") %></span>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
    <div class="card-footer">
      <strong>Total Amount (Paid): NPR <asp:Label ID="lblTotalAmt" runat="server" /></strong>
    </div>
  </div>
</asp:Panel>
</asp:Content>
