<%@ Page Title="Movie Theater Occupancy" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="OccupancyForm.aspx.cs" Inherits="Forms_Complex_OccupancyForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-bar-chart"></i> Movie Theater Occupancy Performer (Top 3)</h3></div>
<p class="text-muted">Shows the top 3 theaters with maximum seat occupancy (%) for a selected movie. Only <strong>Paid</strong> tickets are counted as occupancy.</p>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false" />

<div class="card mb-4">
  <div class="card-header">Select Movie</div>
  <div class="card-body">
    <div class="row g-3 align-items-end">
      <div class="col-md-5">
        <label class="form-label">Movie</label>
        <asp:ListBox ID="lbMovie" runat="server" CssClass="form-select" Rows="6" SelectionMode="Single" />
      </div>
      <div class="col-md-2">
        <asp:Button ID="btnSearch" runat="server" Text="Get Top 3" CssClass="btn btn-danger w-100" OnClick="btnSearch_Click" CausesValidation="false" />
      </div>
    </div>
  </div>
</div>

<asp:Panel ID="pnlMovie" runat="server" Visible="false" CssClass="card mb-4">
  <div class="card-header">Movie Details</div>
  <div class="card-body">
    <div class="row">
      <div class="col-md-3"><strong>Title:</strong> <asp:Label ID="lblMTitle" runat="server" /></div>
      <div class="col-md-2"><strong>Genre:</strong> <asp:Label ID="lblMGenre" runat="server" /></div>
      <div class="col-md-2"><strong>Language:</strong> <asp:Label ID="lblMLang" runat="server" /></div>
      <div class="col-md-2"><strong>Duration:</strong> <asp:Label ID="lblMDur" runat="server" /> min</div>
      <div class="col-md-3"><strong>Release Date:</strong> <asp:Label ID="lblMRel" runat="server" /></div>
    </div>
  </div>
</asp:Panel>

<asp:Panel ID="pnlResults" runat="server" Visible="false">
  <div class="card">
    <div class="card-header bg-dark text-white">Top 3 Theaters by Seat Occupancy</div>
    <div class="card-body p-0">
      <asp:GridView ID="gvOccupancy" runat="server" CssClass="table table-hover mb-0"
          AutoGenerateColumns="false" EmptyDataText="No paid ticket data found.">
        <Columns>
          <asp:TemplateField HeaderText="Rank">
            <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="TheaterName" HeaderText="Theater Name" />
          <asp:BoundField DataField="TheaterCity" HeaderText="City" />
          <asp:BoundField DataField="TheatreType" HeaderText="Type" />
          <asp:BoundField DataField="TotalSeats" HeaderText="Total Seats" />
          <asp:BoundField DataField="PaidTickets" HeaderText="Paid Tickets" />
          <asp:TemplateField HeaderText="Occupancy %">
            <ItemTemplate>
              <div class="d-flex align-items-center gap-2">
                <div class="progress flex-grow-1" style="height:18px; min-width:80px;">
                  <div class="progress-bar bg-danger" style='width:<%# Eval("OccupancyPct") %>%;'>
                    <%# Eval("OccupancyPct", "{0:F1}") %>%
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>
</asp:Panel>
</asp:Content>
