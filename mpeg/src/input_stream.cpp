#include "input_stream.h"

#include <cstdio>
#include <cstdint>
#include <cstring>
#include <stdexcept>

#include "input_stream.h"

using namespace std;

input_stream_t::input_stream_t(const char *filename)
  : fp(nullptr), bitsiz(0), pos(0)
{
  this->fp = std::fopen(filename, "rb");
  if (this->fp == nullptr)
    throw std::runtime_error("Cannot open input file");
  std::fseek(this->fp, 0, SEEK_END);
  this->bitsiz = static_cast<std::size_t>(std::ftell(this->fp)) * 8;
  std::fread(this->buf, 1, is_buf_siz, this->fp);
}

input_stream_t::~input_stream_t() {
  if (this->fp != nullptr) {
    std::fclose(this->fp);
  }
}

void input_stream_t::advance() {
  static const size_t delta = is_buf_siz - is_buf_lim;
  if (this->pos < is_buf_lim*8)
    return;
  std::memcpy(this->buf, this->buf+is_buf_lim, delta);
  std::fread(this->buf+delta, 1, is_buf_siz-delta, this->fp);
  this->pos -= is_buf_lim*8;
}