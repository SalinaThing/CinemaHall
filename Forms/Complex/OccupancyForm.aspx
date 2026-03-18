<%@ Page Title="Movie Theater Occupancy" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
  CodeFile="OccupancyForm.aspx.cs" Inherits="Forms_Complex_OccupancyForm" %>
  <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
      <h3><i class="bi bi-bar-chart"></i> Movie Theater Occupancy Performer (Top 3)</h3>
    </div>
<p class="text-muted small mb-4">Discover the top 3 performing theaters based on paid seat occupancy for your selected film. Real-time data processing ensures accuracy.</p>

<div class="card mb-4 border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark">Select Film to Analyze</h5>
  </div>
  <div class="card-body p-4">
    <div class="row g-4 align-items-center">
      <div class="col-md-6">
        <label class="form-label fw-semibold text-muted small text-uppercase mb-2">Available Movies</label>
        <asp:ListBox ID="lbMovie" runat="server" CssClass="form-select bg-light border-0 px-3 py-2" Rows="5" SelectionMode="Single" />
      </div>
      <div class="col-md-3 mt-md-4 pt-md-2">
        <asp:Button ID="btnSearch" runat="server" Text="Analyze Performance" CssClass="btn btn-danger btn-lg w-100 shadow-sm"
          OnClick="btnSearch_Click" CausesValidation="false" />
      </div>
    </div>
  </div>
</div>

<asp:Panel ID="pnlMovie" runat="server" Visible="false" CssClass="card mb-4 border-0 shadow-sm overflow-hidden">
  <div class="card-header bg-danger text-white py-3 border-0">
    <h5 class="m-0 fw-bold">Movie Overview</h5>
  </div>
  <div class="card-body p-4">
    <div class="row g-4">
      <div class="col-md-4">
        <label class="fw-semibold text-muted small text-uppercase d-block mb-1">Title</label>
        <span class="fs-5 fw-bold text-dark"><asp:Label ID="lblMTitle" runat="server" /></span>
      </div>
      <div class="col-md-2">
        <label class="fw-semibold text-muted small text-uppercase d-block mb-1">Genre</label>
        <span class="fw-bold"><asp:Label ID="lblMGenre" runat="server" /></span>
      </div>
      <div class="col-md-2">
        <label class="fw-semibold text-muted small text-uppercase d-block mb-1">Language</label>
        <span class="fw-bold"><asp:Label ID="lblMLang" runat="server" /></span>
      </div>
      <div class="col-md-2">
        <label class="fw-semibold text-muted small text-uppercase d-block mb-1">Duration</label>
        <span class="fw-bold"><asp:Label ID="lblMDur" runat="server" /> min</span>
      </div>
      <div class="col-md-2">
        <label class="fw-semibold text-muted small text-uppercase d-block mb-1">Release</label>
        <span class="fw-bold text-muted"><asp:Label ID="lblMRel" runat="server" /></span>
      </div>
    </div>
  </div>
</asp:Panel>

<asp:Panel ID="pnlResults" runat="server" Visible="false">
  <div class="card border-0 shadow-sm">
    <div class="card-header bg-transparent py-4 border-bottom d-flex justify-content-between align-items-center">
      <h5 class="m-0 fw-bold text-dark">Top 3 Theater Hall Performance</h5>
      <span class="badge bg-danger-subtle text-danger px-3 py-2 rounded-pill fw-bold">Top Rankings</span>
    </div>
    <div class="card-body p-0">
      <asp:GridView ID="gvOccupancy" runat="server" CssClass="table table-hover mb-0" AutoGenerateColumns="false"
        EmptyDataText="No occupancy data available for this film." GridLines="None">
        <Columns>
          <asp:TemplateField HeaderText="Rank" ItemStyle-CssClass="ps-4" HeaderStyle-CssClass="ps-4">
            <ItemTemplate>
              <div class="bg-light text-muted fw-bold rounded-circle d-flex align-items-center justify-content-center" style="width: 32px; height: 32px;">
                <%# Container.DataItemIndex + 1 %>
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="TheaterName" HeaderText="Theater Name" ItemStyle-CssClass="fw-bold" />
          <asp:BoundField DataField="TheaterCity" HeaderText="Location" />
          <asp:BoundField DataField="TheatreType" HeaderText="Category" />
          <asp:BoundField DataField="TotalSeats" HeaderText="Capacity" />
          <asp:BoundField DataField="PaidTickets" HeaderText="Sold" />
          <asp:TemplateField HeaderText="Occupancy Progress" ItemStyle-CssClass="pe-4" HeaderStyle-CssClass="pe-4">
            <ItemTemplate>
              <div class="d-flex align-items-center gap-3">
                <div class="progress flex-grow-1" style="height:10px; border-radius: 5px; background-color: #f1f5f9;">
                  <div class="progress-bar" role="progressbar" 
                       style='width:<%# Eval("OccupancyPct") %>%; background: linear-gradient(90deg, #ff3b3f, #ff6b6b); border-radius: 5px;'>
                  </div>
                </div>
                <span class="fw-bold text-danger" style="min-width: 50px;"><%# Eval("OccupancyPct", "{0:F1}" ) %>%</span>
              </div>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>
</asp:Panel>
  </asp:Content>