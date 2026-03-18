<%@ Page Title="Theater Movie Details" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="TheaterMovieForm.aspx.cs" Inherits="Forms_Complex_TheaterMovieForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-camera-video"></i> Theater City Hall - Movie & Showtime Details</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false" />

<p class="text-muted small mb-4">View a complete list of films and their scheduled showtimes for any theater in our network. Stay updated with the latest screenings.</p>

<div class="card mb-4 border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark">Select Theater to View</h5>
  </div>
  <div class="card-body p-4">
    <div class="row g-4 align-items-center">
      <div class="col-md-6">
        <label class="form-label fw-semibold text-muted small text-uppercase mb-2">Available Locations</label>
        <asp:ListBox ID="lbTheater" runat="server" CssClass="form-select bg-light border-0 px-3 py-2" Rows="5" SelectionMode="Single" />
      </div>
      <div class="col-md-3 mt-md-4 pt-md-2">
        <asp:Button ID="btnSearch" runat="server" Text="Fetch Details" CssClass="btn btn-danger btn-lg w-100 shadow-sm" OnClick="btnSearch_Click" CausesValidation="false" />
      </div>
    </div>
  </div>
</div>

<asp:Panel ID="pnlTheater" runat="server" Visible="false" CssClass="card mb-4 border-0 shadow-sm overflow-hidden text-white" style="background: linear-gradient(135deg, #ff3b3f, #d32f2f);">
  <div class="card-body p-4">
    <div class="row g-4">
      <div class="col-md-4">
        <label class="fw-semibold small text-uppercase d-block mb-1 text-white-50">Theater</label>
        <span class="fs-4 fw-bold"><asp:Label ID="lblTName" runat="server" /></span>
      </div>
      <div class="col-md-4">
        <label class="fw-semibold small text-uppercase d-block mb-1 text-white-50">Operational City</label>
        <span class="fs-5 fw-bold"><asp:Label ID="lblTCity" runat="server" /></span>
      </div>
      <div class="col-md-4">
        <label class="fw-semibold small text-uppercase d-block mb-1 text-white-50">Type</label>
        <span class="fs-5 fw-bold"><asp:Label ID="lblTType" runat="server" /></span>
      </div>
    </div>
  </div>
</asp:Panel>

<asp:Panel ID="pnlMovies" runat="server" Visible="false">
  <div class="card border-0 shadow-sm">
    <div class="card-header bg-transparent py-3 border-bottom d-flex justify-content-between align-items-center">
      <h5 class="m-0 fw-bold text-dark">Streaming Schedule</h5>
      <span class="badge bg-danger-subtle text-danger px-3 py-2 rounded-pill fw-bold">Active Listings</span>
    </div>
    <div class="card-body p-0">
      <asp:GridView ID="gvMovies" runat="server" CssClass="table table-hover mb-0"
          AutoGenerateColumns="false" EmptyDataText="No movies found for this theater." GridLines="None">
        <Columns>
          <asp:BoundField DataField="MovieTitle" HeaderText="Movie" ItemStyle-CssClass="ps-4 fw-bold" HeaderStyle-CssClass="ps-4" />
          <asp:BoundField DataField="Genre" HeaderText="Genre" />
          <asp:BoundField DataField="Language" HeaderText="Language" />
          <asp:TemplateField HeaderText="Hall">
            <ItemTemplate>
                <div class="fw-bold text-dark"><%# Eval("HallType") %></div>
                <div class="small text-muted">Cap: <%# Eval("HallCapacity") %></div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="ShowName" HeaderText="Show" />
          <asp:BoundField DataField="ShowDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
          <asp:BoundField DataField="ShowType" HeaderText="Timing" />
          <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="pe-4" HeaderStyle-CssClass="pe-4">
            <ItemTemplate>
              <span class='badge rounded-pill px-3 <%# Eval("ShowStatus").ToString() == "Active" ? "bg-success-subtle text-success" : (Eval("ShowStatus").ToString() == "Cancelled" ? "bg-danger-subtle text-danger" : "bg-secondary-subtle text-secondary") %>'>
                <%# Eval("ShowStatus") %>
              </span>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>
</asp:Panel>
</asp:Content>
