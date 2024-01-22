#include <histogram.hpp>
#include <pybind11/pybind11.h>

using namespace Histogram;
namespace py = pybind11;

void Collector_addTrace8(Collector &c, py::buffer b) {
  auto info = b.request();

  if (info.format != py::format_descriptor<uint8_t>::format()) {
    throw std::invalid_argument("Incorrect sample type");
  }
  if (info.ndim != 1) {
    throw std::invalid_argument("Expected 1D array");
  }

  c.addTrace8(std::span<uint8_t>((uint8_t *)info.ptr, info.size));
}

void Collector_addTrace10(Collector &c, py::buffer b) {
  auto info = b.request();

  if (info.format != py::format_descriptor<uint16_t>::format()) {
    throw std::invalid_argument("Incorrect sample type");
  }
  if (info.ndim != 1) {
    throw std::invalid_argument("Expected 1D array");
  }

  c.addTrace10(std::span<uint16_t>((uint16_t *)info.ptr, info.size));
}

PYBIND11_MODULE(pyHistogram, m) {
  m.doc() = "Wrapper for the Histogram library.";

  // Collector
  py::class_<Collector>(m, "Collector")
      .def(pybind11::init<int &>())
      .def("addTrace8", &Collector_addTrace8)
      .def("addTrace10", &Collector_addTrace10)
      .def("getHistograms", &Collector::getHistograms);

  // CacheT, allows conversion to numpy array
  py::class_<Collector::CacheT>(m, "HistogramCache", py::buffer_protocol())
      .def_buffer([](Collector::CacheT &c) -> py ::buffer_info {
        constexpr size_t BinTSize = sizeof(Collector::BinT);
        return py::buffer_info(
            c.data()->data(), // Pointer to beginning of data
            BinTSize,         // size of element
            py::format_descriptor<Collector::BinT>::format(), // format desc
            2,                                                // number of dims
            // dimensions
            std::vector<size_t>{c.size(), Collector::NumberOfBins},
            // stride per index
            std::vector<size_t>{BinTSize * Collector::NumberOfBins, BinTSize});
      });
}