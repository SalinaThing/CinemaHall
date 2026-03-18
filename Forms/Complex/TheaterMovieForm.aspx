<%@ Page Title="Theater Movie Details" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TheaterMovieForm.aspx.cs" Inherits="Forms_Complex_TheaterMovieForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-camera-video"></i> Theater City Hall - Movie & Showtime Details</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false" />

<div class="card mb-4">
  <div class="card-header bg-dark text-white">Select Theater</div>
  <div class="card-body">
    <div class="row g-3 align-items-end">
      <div class="col-md-5">
        <label class="form-label">Theater (TheaterCityHall)</label>
        <asp:ListBox ID="lbTheater" runat="server" CssClass="form-select" Rows="6" SelectionMode="Single" />
      </div>
      <div class="col-md-2">
        <asp:Button ID="btnSearch" runat="server" Text="Show Details" CssClass="btn btn-danger w-100" OnClick="btnSearch_Click" CausesValidation="false" />
      </div>
    </div>
  </div>
</div>

<asp:Panel ID="pnlTheater" runat="server" Visible="false" CssClass="card mb-4">
  <div class="card-header">Theater Details</div>
  <div class="card-body">
    <div class="row">
      <div class="col-md-3"><strong>Theater:</strong> <asp:Label ID="lblTName" runat="server" /></div>
      <div class="col-md-3"><strong>City:</strong> <asp:Label ID="lblTCity" runat="server" /></div>
      <div class="col-md-3"><strong>Type:</strong> <asp:Label ID="lblTType" runat="server" /></div>
    </div>
  </div>
</asp:Panel>

<asp:Panel ID="pnlMovies" runat="server" Visible="false">
  <div class="card">
    <div class="card-header">Movies &amp; Showtimes</div>
    <div class="card-body p-0">
      <asp:GridView ID="gvMovies" runat="server" CssClass="table table-hover table-sm mb-0"
          AutoGenerateColumns="false" EmptyDataText="No movies found for this theater.">
        <Columns>
          <asp:BoundField DataField="MovieTitle" HeaderText="Movie" />
          <asp:BoundField DataField="Genre" HeaderText="Genre" />
          <asp:BoundField DataField="Language" HeaderText="Language" />
          <asp:BoundField DataField="Duration" HeaderText="Duration (min)" />
          <asp:BoundField DataField="ReleaseDate" HeaderText="Release Date" DataFormatString="{0:yyyy-MM-dd}" />
          <asp:BoundField DataField="HallType" HeaderText="Hall Type" />
          <asp:BoundField DataField="HallCapacity" HeaderText="Capacity" />
          <asp:BoundField DataField="ShowName" HeaderText="Show" />
          <asp:BoundField DataField="ShowDate" HeaderText="Show Date" DataFormatString="{0:yyyy-MM-dd}" />
          <asp:BoundField DataField="ShowType" HeaderText="Show Time" />
          <asp:BoundField DataField="ShowStatus" HeaderText="Status" />
        </Columns>
      </asp:GridView>
    </div>
  </div>
</asp:Panel>
</asp:Content>
