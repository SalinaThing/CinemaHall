<%@ Page Title="Movie Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="MovieForm.aspx.cs" Inherits="Forms_Basic_MovieForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-film"></i> Movie Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4 border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Movie" /></h5>
  </div>
  <div class="card-body p-4">
    <asp:HiddenField ID="hfMovieId" runat="server" />
    <div class="row g-4">
      <div class="col-md-6">
        <label class="form-label fw-semibold text-muted small text-uppercase">Movie Title *</label>
        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="e.g. Inception" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle" ErrorMessage="Title is required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Duration (min)</label>
        <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" placeholder="120" />
        <asp:RangeValidator runat="server" ControlToValidate="txtDuration" MinimumValue="1" MaximumValue="500" Type="Integer" ErrorMessage="1-500 min" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label fw-semibold text-muted small text-uppercase">Language</label>
        <asp:DropDownList ID="ddlLang" runat="server" CssClass="form-select bg-light border-0 px-3 py-2">
          <asp:ListItem>English</asp:ListItem>
          <asp:ListItem>Nepali</asp:ListItem>
          <asp:ListItem>Hindi</asp:ListItem>
          <asp:ListItem>Other</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="col-md-4">
        <label class="form-label fw-semibold text-muted small text-uppercase">Select Genre</label>
        <asp:DropDownList ID="ddlGenre" runat="server" CssClass="form-select bg-light border-0 px-3 py-2">
          <asp:ListItem>Action</asp:ListItem>
          <asp:ListItem>Fiction</asp:ListItem>
          <asp:ListItem>Sci-Fi</asp:ListItem>
          <asp:ListItem>Drama</asp:ListItem>
          <asp:ListItem>Comedy</asp:ListItem>
          <asp:ListItem>Horror</asp:ListItem>
          <asp:ListItem>Romance</asp:ListItem>
          <asp:ListItem>Thriller</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="col-md-4">
        <label class="form-label fw-semibold text-muted small text-uppercase">Release Date</label>
        <asp:TextBox ID="txtRelease" runat="server" CssClass="form-control bg-light border-0 px-3 py-2" TextMode="Date" />
      </div>
    </div>
    <div class="mt-4 pt-2">
      <asp:Button ID="btnSave" runat="server" Text="Save Movie" CssClass="btn btn-danger px-4 py-2 me-2 shadow-sm" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Reset Form" CssClass="btn btn-light px-4 py-2 text-muted" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card border-0 shadow-sm">
  <div class="card-header bg-transparent py-3 border-bottom">
    <h5 class="m-0 fw-bold text-dark">Movie Library</h5>
  </div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover mb-0"
        AutoGenerateColumns="false" DataKeyNames="MovieId" OnRowCommand="gvList_RowCommand" GridLines="None">
      <Columns>
        <asp:BoundField DataField="MovieId" HeaderText="ID" ItemStyle-CssClass="ps-4 text-muted small" HeaderStyle-CssClass="ps-4" />
        <asp:BoundField DataField="MovieTitle" HeaderText="Title" ItemStyle-CssClass="fw-bold" />
        <asp:BoundField DataField="Duration" HeaderText="Duration" />
        <asp:BoundField DataField="Language" HeaderText="Language" />
        <asp:BoundField DataField="Genre" HeaderText="Genre" />
        <asp:BoundField DataField="ReleaseDate" HeaderText="Release Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="pe-4 text-end" HeaderStyle-CssClass="pe-4 text-end">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("MovieId") %>' CssClass="btn btn-sm btn-light text-warning me-1" CausesValidation="false" ToolTip="Edit"><i class="bi bi-pencil-square"></i></asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("MovieId") %>' CssClass="btn btn-sm btn-light text-danger" CausesValidation="false" OnClientClick="return confirm('Delete?')" ToolTip="Delete"><i class="bi bi-trash3"></i></asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
