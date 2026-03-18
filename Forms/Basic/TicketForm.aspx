<%@ Page Title="Ticket Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TicketForm.aspx.cs" Inherits="Forms_Basic_TicketForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-ticket-perforated"></i> Ticket Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4">
  <div class="card-header"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Ticket" /></div>
  <div class="card-body">
    <asp:HiddenField ID="hfTicketId" runat="server" />
    <div class="row g-3">
      <div class="col-md-3">
        <label class="form-label">User *</label>
        <asp:DropDownList ID="ddlUser" runat="server" CssClass="form-select" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlUser" InitialValue="" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label">Movie *</label>
        <asp:DropDownList ID="ddlMovie" runat="server" CssClass="form-select" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlMovie" InitialValue="" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-3">
        <label class="form-label">Theater *</label>
        <asp:DropDownList ID="ddlTheater" runat="server" CssClass="form-select" />
      </div>
      <div class="col-md-3">
        <label class="form-label">Hall *</label>
        <asp:DropDownList ID="ddlHall" runat="server" CssClass="form-select" />
      </div>
      <div class="col-md-3">
        <label class="form-label">Show *</label>
        <asp:DropDownList ID="ddlShow" runat="server" CssClass="form-select" />
      </div>
      <div class="col-md-2">
        <label class="form-label">Price (NPR) *</label>
        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrice" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
        <asp:RangeValidator runat="server" ControlToValidate="txtPrice" MinimumValue="0" MaximumValue="10000" Type="Double" ErrorMessage="0-10000" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-2">
        <label class="form-label">Ticket Date *</label>
        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDate" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-2">
        <label class="form-label">Ticket Status</label>
        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
          <asp:ListItem>Booked</asp:ListItem>
          <asp:ListItem>Paid</asp:ListItem>
          <asp:ListItem>Cancelled</asp:ListItem>
        </asp:DropDownList>
      </div>
      <div class="col-md-2">
        <label class="form-label">Payment Status</label>
        <asp:DropDownList ID="ddlPayment" runat="server" CssClass="form-select">
          <asp:ListItem>Pending</asp:ListItem>
          <asp:ListItem>Completed</asp:ListItem>
          <asp:ListItem>Failed</asp:ListItem>
        </asp:DropDownList>
      </div>
    </div>
    <div class="mt-3">
      <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-danger me-2" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card">
  <div class="card-header">Ticket List</div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover table-sm mb-0"
        AutoGenerateColumns="false" DataKeyNames="TicketId" OnRowCommand="gvList_RowCommand">
      <Columns>
        <asp:BoundField DataField="TicketId" HeaderText="ID" />
        <asp:BoundField DataField="Username" HeaderText="User" />
        <asp:BoundField DataField="MovieTitle" HeaderText="Movie" />
        <asp:BoundField DataField="TheaterName" HeaderText="Theater" />
        <asp:BoundField DataField="ShowName" HeaderText="Show" />
        <asp:BoundField DataField="TicketPrice" HeaderText="Price" DataFormatString="{0:N0}" />
        <asp:BoundField DataField="TicketDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="TicketStatus" HeaderText="Status" />
        <asp:BoundField DataField="PaymentStatus" HeaderText="Payment" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("TicketId") %>' CssClass="btn btn-sm btn-warning btn-action"><i class="bi bi-pencil"></i> Edit</asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("TicketId") %>' CssClass="btn btn-sm btn-danger btn-action" OnClientClick="return confirm('Delete?')"><i class="bi bi-trash"></i> Delete</asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
