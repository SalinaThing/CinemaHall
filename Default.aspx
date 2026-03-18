<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h3><i class="bi bi-speedometer2"></i> ADMIN DASHBOARD</h3>
    </div>
    
    <!-- Stats Row -->
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="card stat-card h-100">
                <div class="card-body">
                    <div class="stat-label">Total Movies</div>
                    <div class="stat-value"><asp:Label ID="lblMovies" runat="server" /></div>
                    <div class="mt-2 text-muted small"><i class="bi bi-film me-1"></i> Library Size</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card h-100" style="border-left-color: #4361ee;">
                <div class="card-body">
                    <div class="stat-label">Tickets Sold</div>
                    <div class="stat-value"><asp:Label ID="lblTickets" runat="server" /></div>
                    <div class="mt-2 text-muted small"><i class="bi bi-ticket-perforated me-1"></i> All Time</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card h-100" style="border-left-color: #2ec4b6;">
                <div class="card-body">
                    <div class="stat-label">Box Office</div>
                    <div class="stat-value">Rs <asp:Label ID="lblRevenue" runat="server" Text="0" /></div>
                    <div class="mt-2 text-muted small"><i class="bi bi-currency-dollar me-1"></i> Gross Earnings</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card h-100" style="border-left-color: #ff9f1c;">
                <div class="card-body">
                    <div class="stat-label">Avg Occupancy</div>
                    <div class="stat-value"><asp:Label ID="lblAvgOccupancy" runat="server" Text="0" />%</div>
                    <div class="mt-2 text-muted small"><i class="bi bi-percent me-1"></i> Seat Fill Rate</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row -->
    <div class="row g-4 mb-5">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header"><i class="bi bi-graph-up me-2"></i> Monthly Sales Trand</div>
                <div class="card-body">
                    <div style="height: 300px;">
                        <canvas id="salesChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-header"><i class="bi bi-pie-chart me-2"></i> Theater Occupancy</div>
                <div class="card-body">
                    <div style="height: 300px;">
                        <canvas id="occupancyChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Sales Table & Quick Actions -->
    <div class="row g-4">
        <div class="col-md-8">
            <div class="card h-100">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span><i class="bi bi-clock-history me-2"></i> Recent Ticket Sales</span>
                    <a href='<%= ResolveUrl("~/Forms/Basic/TicketForm.aspx") %>' class="btn btn-sm btn-outline-danger">View All</a>
                </div>
                <div class="card-body p-0">
                    <asp:GridView ID="gvRecent" runat="server" CssClass="table table-hover mb-0 border-0"
                        AutoGenerateColumns="false" EmptyDataText="No recent sales found.">
                        <Columns>
                            <asp:BoundField DataField="TicketId" HeaderText="ID" />
                            <asp:BoundField DataField="Username" HeaderText="Customer" />
                            <asp:BoundField DataField="MovieTitle" HeaderText="Movie" />
                            <asp:TemplateField HeaderText="Price">
                                <ItemTemplate>Rs <%# Eval("TicketPrice", "{0:N0}") %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='badge <%# Eval("TicketStatus").ToString() == "Paid" ? "bg-success" : "bg-warning" %>'>
                                        <%# Eval("TicketStatus") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-header"><i class="bi bi-lightning-charge me-2"></i> Quick Actions</div>
                <div class="card-body">
                    <div class="list-group list-group-flush">
                        <a href='<%= ResolveUrl("~/Forms/Basic/MovieForm.aspx") %>' class="list-group-item list-group-item-action px-0 border-0">
                            <i class="bi bi-plus-circle text-danger me-2"></i> Add New Movie
                        </a>
                        <a href='<%= ResolveUrl("~/Forms/Basic/ShowForm.aspx") %>' class="list-group-item list-group-item-action px-0 border-0">
                            <i class="bi bi-calendar-plus text-danger me-2"></i> Schedule Show
                        </a>
                        <a href='<%= ResolveUrl("~/Forms/Complex/OccupancyForm.aspx") %>' class="list-group-item list-group-item-action px-0 border-0">
                            <i class="bi bi-download text-danger me-2"></i> Export Occupancy Report
                        </a>
                        <a href='<%= ResolveUrl("~/Forms/Complex/UserTicketForm.aspx") %>' class="list-group-item list-group-item-action px-0 border-0">
                            <i class="bi bi-search text-danger me-2"></i> Lookup User History
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Chart Scripts -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Sales Chart
            const salesCtx = document.getElementById('salesChart').getContext('2d');
            new Chart(salesCtx, {
                type: 'line',
                data: {
                    labels: <%= GetChartLabels() %>,
                    datasets: [{
                        label: 'Revenue (Rs)',
                        data: <%= GetChartData() %>,
                        borderColor: '#e63946',
                        backgroundColor: 'rgba(230, 57, 70, 0.1)',
                        borderWidth: 3,
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#ffffff',
                        pointBorderColor: '#e63946',
                        pointRadius: 5
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        y: { beginAtZero: true, grid: { color: '#f0f0f0' } },
                        x: { grid: { display: false } }
                    }
                }
            });

            // Occupancy Chart
            const occCtx = document.getElementById('occupancyChart').getContext('2d');
            new Chart(occCtx, {
                type: 'doughnut',
                data: {
                    labels: <%= GetOccupancyLabels() %>,
                    datasets: [{
                        data: <%= GetOccupancyData() %>,
                        backgroundColor: ['#e63946', '#4361ee', '#2ec4b6', '#ff9f1c', '#f1faee'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { position: 'bottom', labels: { usePointStyle: true, padding: 20 } }
                    },
                    cutout: '70%'
                }
            });
        });
    </script>
</asp:Content>
