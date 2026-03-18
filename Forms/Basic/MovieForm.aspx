<%@ Page Title="Movie Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MovieForm.aspx.cs" Inherits="Forms_Basic_MovieForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-film"></i> Movie Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4">
  <div class="card-header"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Movie" /></div>
  <div class="card-body">
    <asp:HiddenField ID="hfMovieId" runat="server" />
    <div class="row g-3">
      <div class="col-md-6">
        <label class="form-label">Movie Title *</label>
        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label">Duration (min)</label>
        <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" />
        <asp:RangeValidator runat="server" ControlToValidate="txtDuration" MinimumValue="1" MaximumValue="500" Type="Integer" ErrorMessage="1-500 min" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label">Language</label>
        <asp:DropDownList ID="ddlLang" runat="server" CssClass="form-select">
          <asp:ListItem>English</asp:ListItem>
          <asp:ListItem>Nepali</asp:ListItem>
          <asp:ListItem>Hindi</asp:ListItem>
          <asp:ListItem>Other</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="col-md-4">
        <label class="form-label">Genre</label>
        <asp:DropDownList ID="ddlGenre" runat="server" CssClass="form-select">
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
        <label class="form-label">Release Date</label>
        <asp:TextBox ID="txtRelease" runat="server" CssClass="form-control" TextMode="Date" />
      </div>
    </div>
    <div class="mt-3">
      <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-danger me-2" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card">
  <div class="card-header">Movie List</div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover table-sm mb-0"
        AutoGenerateColumns="false" DataKeyNames="MovieId" OnRowCommand="gvList_RowCommand">
      <Columns>
        <asp:BoundField DataField="MovieId" HeaderText="ID" />
        <asp:BoundField DataField="MovieTitle" HeaderText="Title" />
        <asp:BoundField DataField="Duration" HeaderText="Duration" />
        <asp:BoundField DataField="Language" HeaderText="Language" />
        <asp:BoundField DataField="Genre" HeaderText="Genre" />
        <asp:BoundField DataField="ReleaseDate" HeaderText="Release Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("MovieId") %>' CssClass="btn btn-sm btn-warning btn-action"><i class="bi bi-pencil"></i> Edit</asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("MovieId") %>' CssClass="btn btn-sm btn-danger btn-action" OnClientClick="return confirm('Delete?')"><i class="bi bi-trash"></i> Delete</asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
