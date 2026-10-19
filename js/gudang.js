
const dataBarangMaster = {
    "Beras Premium 5 kg": { stok: 18, min: 10 },
    "Air Mineral 600 ml": { stok: 8, min: 15 },
    "Mi Instan Goreng": { stok: 46, min: 20 },
    "Sabun Cuci Piring": { stok: 12, min: 12 },
    "Buku Tulis 38 Lembar": { stok: 75, min: 25 }
};

// Fungsi memperbarui status label warna Merah/Hijau
function updateStatusLabel(namaBarang) {
    const item = dataBarangMaster[namaBarang];
    const stokEl = document.getElementById(`stok-${namaBarang}`);
    const badgeEl = document.getElementById(`badge-${namaBarang}`);
    
    if (stokEl && badgeEl) {
        stokEl.innerText = item.stok;
        if (item.stok <= item.min) {
            badgeEl.className = "px-2 py-1 rounded text-xs font-semibold bg-red-100 text-red-600";
            badgeEl.innerText = "Merah (Stok Menipis)";
        } else {
            badgeEl.className = "px-2 py-1 rounded text-xs font-semibold bg-green-100 text-green-600";
            badgeEl.innerText = "Hijau (Aman)";
        }
    }
}

// Event saat halaman dimuat
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('formBarangMasuk');
    const btnFilter = document.getElementById('btnFilter');
    const btnReset = document.getElementById('btnReset');

    // 1. Submit Form Nota Barang Datang & Trigger Stok Otomatis
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();

            const supplier = document.getElementById('supplier').value;
            const barang = document.getElementById('barang').value;
            const tanggal = document.getElementById('tanggalDatang').value;
            const kuantitas = parseInt(document.getElementById('kuantitas').value);

            if (dataBarangMaster[barang]) {
                dataBarangMaster[barang].stok += kuantitas;
                updateStatusLabel(barang);
            }

            const tabelHistori = document.getElementById('tabelHistori');
            if (tabelHistori) {
                const row = document.createElement('tr');
                row.className = "border-b histori-row";
                row.setAttribute('data-tanggal', tanggal);
                row.innerHTML = `
                    <td class="p-3">${tanggal}</td>
                    <td class="p-3">${supplier}</td>
                    <td class="p-3">${barang}</td>
                    <td class="p-3 text-blue-600 font-semibold">+${kuantitas}</td>
                `;
                tabelHistori.appendChild(row);
            }

            this.reset();
            alert("Nota berhasil disimpan dan stok gudang otomatis bertambah!");
        });
    }

    // 2. Filter Rentang Tanggal Histori
    if (btnFilter) {
        btnFilter.addEventListener('click', function() {
            const dari = document.getElementById('filterDari').value;
            const sampai = document.getElementById('filterSampai').value;
            const rows = document.querySelectorAll('.histori-row');

            rows.forEach(row => {
                const tglRow = row.getAttribute('data-tanggal');
                if ((dari && tglRow < dari) || (sampai && tglRow > sampai)) {
                    row.style.display = 'none';
                } else {
                    row.style.display = '';
                }
            });
        });
    }

    // 3. Reset Filter
    if (btnReset) {
        btnReset.addEventListener('click', function() {
            document.getElementById('filterDari').value = '';
            document.getElementById('filterSampai').value = '';
            const rows = document.querySelectorAll('.histori-row');
            rows.forEach(row => row.style.display = '');
        });
    }
});